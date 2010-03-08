//
//  GunBoundGamePlayViewController.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GunBoundGamePlayViewController.h"
#import "MuzzleView.h"
#import "Mount.h"
#import "MountView.h"
#import "MissileView.h"


#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark Buttons

- (IBAction) stopTimerButton:(id)sender
{
	if (mTimer != nil) 
		[mTimer invalidate];
	mTimer = nil;
}

- (IBAction) fireButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(addPower:) userInfo:nil repeats:YES];
}

- (IBAction) fireMissile:(id)sender
{
	[self stopTimerButton:sender];
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(-20, -20, 20, 20)];
	//mMissileView.backgroundColor = [UIColor blueColor];
	mMissileView.mPower = mPower;
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	//[self.view addSubview:mMissileView];
	//[self.view bringSubviewToFront:mMissileView];
	mMissileView.hidden = NO;
	[mMissileView fireMissileFrom:mMountView toEnemyMountView:mEnemyMountView];
	[mMissileView release];
	mPower = 0;
	[self changePlayer];	
}

- (IBAction) exitGame:(id)sender
{
	
}

#pragma mark avatar movements

-(void) addPower:(id)sender
{
	mPower += 1.5;
	powerLabel.text = [NSString stringWithFormat:@"%d",mPower];
	//NSLog(@"mpower %d",mPower);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set background image
	UIColor *bgImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg01.png"]];
	self.view.backgroundColor = bgImage;
	[bgImage release];
		
	// add player 1
	mMountView1 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	mMountView1.mMount.player = 1;
	[self.view addSubview:mMountView1];
	[mMountView1 setRandomLocation];
	mMountView1.mMount.angle = 45.0;
	// alloc mount muzzle 
	mMountView1.mMuzzleView = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView1.center.x - 12, mMountView1.center.y - 27, 75, 75) forPlayer:1];
	[mMountView1.mMuzzleView rotateAngle:-45.0];
	[self.view insertSubview:mMountView1.mMuzzleView belowSubview:mMountView1];
	
	
	// add player 2
	mMountView2 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	mMountView2.mMount.player = 2;
	[self.view addSubview:mMountView2];
	[mMountView2 setRandomLocation];
	mMountView2.mMount.angle = 135.0;
	// alloc mount muzzle 
	mMountView2.mMuzzleView = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView2.center.x - 63, mMountView2.center.y - 27, 75, 75) forPlayer:2];
	[mMountView2.mMuzzleView rotateAngle:-135.0];
	[self.view insertSubview:mMountView2.mMuzzleView belowSubview:mMountView2];
	 
	
	// set player 1 to be the first to move
	mMountView = mMountView1;
	mEnemyMountView = mMountView2;
}

- (void) changePlayer
{
	mMountView.mMuzzleView.hidden = YES;
	mEnemyMountView = mMountView;
	if (mMountView == mMountView1) {
		mMountView = mMountView2;
	}
	else {
		mMountView = mMountView1;
	}
	mMountView.mMuzzleView.hidden = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:self.view];
	//NSLog(@"touch began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:self.view];
	//NSLog(@"previous position x: %f y: %f",mGestureStartPoint.x,mGestureStartPoint.y);
	//NSLog(@"current position x: %f y: %f",currentPosition.x,currentPosition.y);
	
	
	
	// Arc Tangent Formula
	CGFloat currentAngle = atan2(mGestureStartPoint.y - mMountView.mMuzzleView.center.y,mGestureStartPoint.x - mMountView.mMuzzleView.center.x)*180.0/M_PI;
	
	
	if(currentAngle < -90.0 && mMountView.mMount.player == 1){
		currentAngle = -90.0;
	}
	else if(currentAngle > 45.0 && mMountView.mMount.player == 1){
		currentAngle = 45.0;
	}
	
	if(currentAngle <= 135.0 && currentAngle > 0.0 && mMountView.mMount.player == 2){
		currentAngle = 135.0;
	}
	else if(currentAngle > -90.0 && currentAngle < 0.0 && mMountView.mMount.player == 2){
		currentAngle = -90.0;
	}
	
	[mMountView.mMuzzleView rotateAngle:currentAngle];
	mMountView.mMount.angle = currentAngle*-1;
		
	mGestureStartPoint = currentPosition;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	//return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
	[mMountView1 release];
	[mMountView2 release];
	
	[mMountView release];
	[mEnemyMountView release];
	[mMissileView release];
}


@end
