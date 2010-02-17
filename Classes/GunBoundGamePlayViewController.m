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


#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

@synthesize mMountView;
@synthesize mMountMuzzleView;
@synthesize mMissileView;
@synthesize mTimer;


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
	mMissileView.hidden = NO;
	[mMissileView fireMissileFrom:mMountView];	
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
	mMissileView = [Missile initMissile];
	[self.view addSubview:mMissileView];
	
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
