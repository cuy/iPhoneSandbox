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
@synthesize angleLabel;
@synthesize angleSlider;


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

- (IBAction) upButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarUp:) userInfo:nil repeats:YES];	
}

- (IBAction) downButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarDown:) userInfo:nil repeats:YES];	
}
/*
- (IBAction)upAngleMuzzle:(id)sender
{
	[mMountMuzzleView rotateMuzzleUp];
}

- (IBAction)downAngleMuzzle:(id)sender
{
	[mMountMuzzleView rotateMuzzleDown];
}
*/
- (IBAction) stopTimerButton:(id)sender
{
	if (mTimer != nil) 
		[mTimer invalidate];
	mTimer = nil;
}

- (IBAction) fireButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addPower:) userInfo:nil repeats:YES];
}

- (IBAction) fireMissile:(id)sender
{
	[self stopTimerButton:sender];
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(0.0, 0.0, 480, 320)];
	mMissileView.backgroundColor = [UIColor clearColor];
	mMissileView.mPower = mPower;
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	//[self.view addSubview:mMissileView];
	//[self.view bringSubviewToFront:mMissileView];
	mMissileView.hidden = NO;
	[mMissileView fireMissileFrom:mMountView];
	[mMissileView release];
	mPower = 0;
	//[self changePlayer];	
}

- (IBAction) changeAngle:(UISlider *) sender
{
	angleLabel.text = [NSString stringWithFormat:@"%.1f",[sender value]];
	mMountView.mMount.angle = (CGFloat)[sender value];
}

- (IBAction) exitGame:(id)sender
{
	
}

#pragma mark avatar movements

- (void) moveAvatarUp:(id)sender
{
	[mMountView moveUpMount];
}

- (void) moveAvatarDown:(id)sender 
{
	[mMountView moveDownMount];
}

-(void) addPower:(id)sender
{
	mPower+=1;
	powerLabel.text = [NSString stringWithFormat:@"%d",mPower];
	//NSLog(@"mpower %d",mPower);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg01.png"]];
	mAngle = 0;
	// add player 1
	mMount1 = [[Mount alloc] init];
	mMount1.player = 1;
	mMount1.bgColor = [UIColor blueColor];
	mMountView1 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withMount:mMount1];
	mMountView1.backgroundColor = [UIColor clearColor];
	[self.view addSubview:mMountView1];
	[mMountView1 setRandomLocation];
	// alloc mount muzzle 
	mMuzzleView1 = [[MuzzleView alloc] initWithFrame:CGRectMake(mMountView1.center.x - 3, mMountView1.center.y - 27, 75, 75)];
	mMuzzleView1.backgroundColor = [UIColor clearColor];
	mMountView1.mMuzzleView = mMuzzleView1;
	[self.view insertSubview:mMuzzleView1 belowSubview:mMountView1];
	
	
	// add player 2
	mMount2 = [[Mount alloc] init];
	mMount2.player = 2;
	mMount2.bgColor = [UIColor redColor];
	mMountView2 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withMount:mMount2];
	mMountView2.backgroundColor = [UIColor clearColor];
	[self.view addSubview:mMountView2];
	[mMountView2 setRandomLocation];
	
	// set player 1 to be the first to move
	mMountView = mMountView1;
	mMuzzleView = mMuzzleView1;
}

- (void) changePlayer
{
	if (mMountView == mMountView1) {
		mMountView = mMountView2;
	}
	else {
		mMountView = mMountView1;
	}
	
	mMountView.mMount.angle = (CGFloat) [angleSlider value];

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
	
	if (currentPosition.y > mGestureStartPoint.y) {
	//	NSLog(@"down");
		if((mAngle + 5) <= 90)
			mAngle += 5;
		[mMuzzleView rotateAngle:mAngle];
		mMountView.mMount.angle = mAngle;
	}
	
	else if (currentPosition.y < mGestureStartPoint.x) {
	//	NSLog(@"up");
		if ((mAngle - 5) >= -90)
			mAngle -= 5;
		[mMuzzleView rotateAngle:mAngle];
		mMountView.mMount.angle = mAngle;
	}
	
	mGestureStartPoint = currentPosition;	
	NSLog(@"mAngle %f",mAngle);
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
	
	[mMountView release];
	[mMissileView release];
}


@end
