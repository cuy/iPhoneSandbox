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
#import "Missile.h"


#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

@synthesize managedObjectContext;
@synthesize managedObjectModel;

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
	
	// allocate missileView
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(mMountView.mMuzzleView.center.x, mMountView.mMuzzleView.center.y, 31, 14)];
	// set missile velocity
	mMissileView.mMissile.velocity = mPower;
	//set missile cx and cy
	mMissileView.mMissile.cx = mMountView.mMuzzleView.center.x;
	mMissileView.mMissile.cy = mMountView.mMuzzleView.center.y;
	// set missile starting angle
	mMissileView.mMissile.angle = mMountView.mMount.angle;
	//mMissileView.mMissile.position = mMountView.mMuzzleView.position;
	// insert subview below the current player's mountview
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	// call firemissilefrom method 
	[mMissileView fireMissileFrom:mMountView toEnemyMountView:mEnemyMountView];
	[mMissileView setDelegate:self];
	// release missileview
	[mMissileView release];
	// re-init mpower
	mPower = 0;
	// call change played method
	//[self changePlayer];
	
	
	//disable power button
	[powerButton setEnabled:NO];
}

- (IBAction) exitGame:(id)sender
{
	
}

#pragma mark avatar movements

-(void) addPower:(id)sender
{
	// Check if the power is greater than the MAX POWER which is 145
	
	if(mPower >= 145){
		//set the power to the max power
		mPower = 145;
	
	}
	// otherwise increment the power by 5
	else {
		mPower += 5;
	}

	//Set PowerBar
	CGFloat mScalex = mPower;
	CGAffineTransform trans = CGAffineTransformMakeScale(mScalex/145*1, 1.0);
	powerBar.transform = trans;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//set the power button to enabled
	[powerButton setEnabled:YES];
	
	//set powerGuage default scale and orientation;
	CGAffineTransform defaultScale = CGAffineTransformMakeScale(0.01, 1.0);
	CGPoint defaultCenter = powerBar.center;
	defaultCenter.x -= 50.0;
	[powerBar.layer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
	powerBar.center = defaultCenter;
	powerBar.transform = defaultScale;
	
	// set background image
	UIColor *bgImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"gameBG.png"]];
	self.view.backgroundColor = bgImage;
	[bgImage release];
		
	// add player 1
	mMountView1 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	// set player
	mMountView1.mMount.player = 1;
	// add subview
	[self.view addSubview:mMountView1];
	// set to random location
	[mMountView1 setRandomLocation];
	// alloc mount muzzle 
	mMountView1.mMuzzleView = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView1.center.x - 12, mMountView1.center.y - 27, 75, 75) forPlayer:1];
	// set muzzle starting angle
	mMountView1.mMount.angle = 45.0;
	[mMountView1.mMuzzleView rotateAngle:-45.0];
	// insert subview below player's mountview
	[self.view insertSubview:mMountView1.mMuzzleView belowSubview:mMountView1];
	
	
	// add player 2
	mMountView2 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	// set player
	mMountView2.mMount.player = 2;
	// add to subview
	[self.view addSubview:mMountView2];
	// set to random location
	[mMountView2 setRandomLocation];
	// alloc mount muzzle 
	mMountView2.mMuzzleView = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView2.center.x - 63, mMountView2.center.y - 27, 75, 75) forPlayer:2];
	// set muzzle starting angle
	mMountView2.mMount.angle = 135.0;
	[mMountView2.mMuzzleView rotateAngle:-135.0];
	// insert subview below player's mountview
	[self.view insertSubview:mMountView2.mMuzzleView belowSubview:mMountView2];
	 
	
	// set player 1 to be the first to move
	mMountView = mMountView1;
	// set player 2 to be the enemy
	mEnemyMountView = mMountView2;
	
	// set powerlabel
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
}

- (void) changePlayer
{	
	// hide current player muzzle
	mMountView.mMuzzleView.hidden = YES;
	
	mEnemyMountView = mMountView;
	if (mMountView == mMountView1) {
		mMountView = mMountView2;
	}
	else {
		mMountView = mMountView1;
	}
	
	// unhide new player muzzle
	mMountView.mMuzzleView.hidden = NO;
	
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
	
	//enable power button
	[powerButton setEnabled:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if([btnFire isEnabled]){
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:self.view];
	//NSLog(@"touch began");
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// Activate touch move if the FIRE BUTTON is enabled :D
	if([powerButton isEnabled]){
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
	
	// set powerlabel
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
	NSLog(@"label: %@", angleLabel.text);
	}
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
