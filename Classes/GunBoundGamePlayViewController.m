//
//  GunBoundGamePlayViewController.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GunBoundGamePlayViewController.h"
#import "Mount.h"
#import "MountMuzzle.h"
#import "Missile.h"
#import "MissileView.h"


#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

@synthesize mMountView;
@synthesize mMountMuzzleView;
@synthesize mTimer;
@synthesize mMissile, mMissileView;


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

- (IBAction)upButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarUp:) userInfo:nil repeats:YES];	
}

- (IBAction)downButton:(id)sender
{
	mTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarDown:) userInfo:nil repeats:YES];	
}

- (IBAction)upAngleMuzzle:(id)sender
{
	[mMountMuzzleView rotateMuzzleUp];
}

- (IBAction)downAngleMuzzle:(id)sender
{
	[mMountMuzzleView rotateMuzzleDown];
}

- (IBAction)stopTimerButton:(id)sender
{
	if (mTimer != nil) 
		[mTimer invalidate];
	mTimer = nil;
}

- (IBAction)fireButton:(id)sender
{
	//mMissileView = [Missile alloc];
	//[self.view addSubview:mMissileView];
	//[mMissileView setNeedsDisplay];
	
	//mMissileView.hidden = NO;
	//[mMissileView fireMissileFrom:mMountView];	
	//[mMissileView release];
	//mMissile = [Missile alloc];
	
	//mMissile = [[Missile alloc] init];
	//mMissile.position = mMountView.center;
	//[self.view bringSubviewToFront:mMissileView];
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(0.0, 0.0, 480, 320)];
	mMissileView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:mMissileView];
	[self.view bringSubviewToFront:mMissileView];
	//mMissileView.hidden = YES;
	mMissileView.hidden = NO;
	[mMissileView fireMissileFrom:mMountView];
	//[self.view sendSubviewToBack:mMissileView];
	//[mMissile release];
	[mMissileView release];
}

- (IBAction)exitGame:(id)sender
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg01.png"]];
	
	// add missile
	//mMissileView = [[MissileView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//mMissileView.backgroundColor = [UIColor clearColor];
	//mMissileView = [Missile initMissile];
	//[self.view addSubview:mMissileView];
	//[self.view bringSubviewToFront:mMissileView];
	//mMissileView.hidden = YES;

	// add mount
	mMountMuzzleView = [MountMuzzle initMuzzle];
	mMountView = [Mount initMountWithMuzzle:mMountMuzzleView];
	[self.view addSubview:mMountView];	
	[mMountView setRandomLocation];

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
}


@end
