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

@synthesize mMountView;
@synthesize mMuzzleView;
@synthesize mTimer;
@synthesize mMissileView;

@synthesize mMountView1,mMountView2;
@synthesize mMount1,mMount2;
@synthesize mMuzzleView1,mMuzzleView2;

@synthesize powerLabel;


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
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(-20, 0.0, 20, 20)];
	//mMissileView.backgroundColor = [UIColor blueColor];
	mMissileView.mPower = mPower;
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	//[self.view addSubview:mMissileView];
	//[self.view bringSubviewToFront:mMissileView];
	mMissileView.hidden = NO;
	[mMissileView fireMissileFrom:mMountView toEnemyMountView:mEnemyMountView];
	[mMissileView release];
	mPower = 0;
	mAccel = 0;
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
		
	mAngle = 0;
	mAccel = 0;
	// add player 1
	mMount1 = [[Mount alloc] init];
	mMount1.player = 1;
	mMount1.bgColor = [UIColor blueColor];
	mMountView1 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withMount:mMount1];
	[self.view addSubview:mMountView1];
	[mMountView1 setRandomLocation];
	mMountView1.mMount.angle = 45.0;
	// alloc mount muzzle 
	mMuzzleView1 = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView1.center.x - 12, mMountView1.center.y - 27, 75, 75) forPlayer:1];
	mMuzzleView1.backgroundColor = [UIColor clearColor];
	mMountView1.mMuzzleView = mMuzzleView1;
	[mMuzzleView1 rotateAngle:-45.0];
	[self.view insertSubview:mMuzzleView1 belowSubview:mMountView1];
	
	
	// add player 2
	mMount2 = [[Mount alloc] init];
	mMount2.player = 2;
	mMount2.bgColor = [UIColor redColor];
	mMountView2 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withMount:mMount2];
	[self.view addSubview:mMountView2];
	[mMountView2 setRandomLocation];
	mMountView2.mMount.angle = 135.0;
	// alloc mount muzzle 
	mMuzzleView2 = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView2.center.x - 63, mMountView2.center.y - 27, 75, 75) forPlayer:2];
	mMuzzleView2.backgroundColor = [UIColor clearColor];
	mMountView2.mMuzzleView = mMuzzleView2;
	mMuzzleView2.hidden = YES;
	[mMuzzleView2 rotateAngle:-135.0];
	[self.view insertSubview:mMuzzleView2 belowSubview:mMountView2];

	
	// set player 1 to be the first to move
	mMountView = mMountView1;
	mMuzzleView = mMuzzleView1;
	mEnemyMountView = mMountView2;
}

- (void) changePlayer
{
	mMuzzleView.hidden = YES;
	mEnemyMountView = mMountView;
	if (mMountView == mMountView1) {
		mMountView = mMountView2;
		mMuzzleView = mMuzzleView2;
	}
	else {
		mMountView = mMountView1;
		mMuzzleView = mMuzzleView1;
	}
	mMuzzleView.hidden = NO;
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
	
	
	/**
	 * Arc Tangent Formula
	 */
	CGFloat currentAngle = atan2(mGestureStartPoint.y-mMuzzleView.center.y,mGestureStartPoint.x-mMuzzleView.center.x)*180.0/M_PI;
	
	
	if(currentAngle < -90.0 && mMuzzleView == mMuzzleView1){
		currentAngle = -90.0;
	}
	else if(currentAngle > 45.0 && mMuzzleView == mMuzzleView1){
		currentAngle = 45.0;
	}
	
	if(currentAngle <= 135.0 && currentAngle > 0.0 && mMuzzleView == mMuzzleView2){
		currentAngle = 135.0;
	}
	else if(currentAngle > -90.0 && currentAngle < 0.0 && mMuzzleView == mMuzzleView2){
		currentAngle = -90.0;
	}
	
	[mMuzzleView rotateAngle:currentAngle];
	mMountView.mMount.angle = currentAngle*-1;
	
	//NSLog(@"Current Angle = %f", currentAngle);
	
	mGestureStartPoint = currentPosition;
	//NSLog(@"mAngle %f",mAngle);
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
	[mMount1 release];
	[mMount2 release];
	[mMountView1 release];
	[mMountView2 release];
	[mMuzzleView1 release];
	[mMuzzleView2 release];
	
	[mMountView release];
	[mMissileView release];
}


@end
