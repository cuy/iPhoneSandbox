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

- (IBAction)stopTimerButton:(id)sender {
	if (mTimer != nil) 
		[mTimer invalidate];
	mTimer = nil;
}

- (IBAction) fireButton:(id)sender {
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(addPower:) userInfo:nil repeats:YES];
}

- (IBAction)fireMissile:(id)sender {
	[self stopTimerButton:sender];
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(mMountView.mMuzzleView.center.x, mMountView.mMuzzleView.center.y, 31, 14)];
	mMissileView.mMissile.velocity = mPower;
	mMissileView.mMissile.cx = mMountView.mMuzzleView.center.x;
	mMissileView.mMissile.cy = mMountView.mMuzzleView.center.y;
	mMissileView.mMissile.angle = mMountView.mMount.angle;
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	[mMissileView fireMissileFrom:mMountView toEnemyMountView:mEnemyMountView];
	[mMissileView setDelegate:self];
	[mMissileView release];

	// re-init mpower
	mPower = 0;

	//disable power button
	[powerButton setEnabled:NO];
}

- (IBAction)exitGame:(id)sender {
	
}

#pragma mark avatar movements

-(void)addPower:(id)sender
{
	// Check if the power is greater than the MAX POWER which is 145
	if(mPower >= 145) {
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
	mMountView1 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) forPlayer:1];
	[self.view addSubview:mMountView1];
	[mMountView1 setRandomLocation];
	mMountView1.mMount.angle = 45.0;
    mMountView1.mMuzzleView.initialAngle = -45.0;
    CGPoint offsets1 = CGPointMake(-12, -27);
    mMountView1.offsets = offsets1;
	
	// add player 2
	mMountView2 = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) forPlayer:2];
	[self.view addSubview:mMountView2];
	[mMountView2 setRandomLocation];
	mMountView2.mMount.angle = 135.0;
    mMountView2.mMuzzleView.initialAngle = -135.0;
    CGPoint offsets2 = CGPointMake(-63, -27);
    mMountView2.offsets = offsets2;

	// set player 1 to be the first to move
	mMountView = mMountView1;
	// set player 2 to be the enemy
	mEnemyMountView = mMountView2;
	
	// set powerlabel
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
}

- (void)changePlayer {
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
	if([btnFire isEnabled]) {
        UITouch *touch = [touches anyObject];
        mGestureStartPoint = [touch locationInView:self.view];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// Activate touch move if the FIRE BUTTON is enabled :D
	if ([powerButton isEnabled]) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPosition = [touch locationInView:self.view];

        // Arc Tangent Formula
        CGFloat currentAngle = atan2(mGestureStartPoint.y - mMountView.mMuzzleView.center.y,mGestureStartPoint.x - mMountView.mMuzzleView.center.x)*180.0/M_PI;

        if (currentAngle < -90.0 && mMountView.mMount.player == 1) {
            currentAngle = -90.0;
        }
        else if (currentAngle > 45.0 && mMountView.mMount.player == 1) {
            currentAngle = 45.0;
        }
	
        if (currentAngle <= 135.0 && currentAngle > 0.0 && mMountView.mMount.player == 2) {
            currentAngle = 135.0;
        }
        else if (currentAngle > -90.0 && currentAngle < 0.0 && mMountView.mMount.player == 2) {
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
