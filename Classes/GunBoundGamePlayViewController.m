//
//  GunBoundGamePlayViewController.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GunBoundGamePlayViewController.h"
#import "Mount.h"


#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

@synthesize mountOneView;
@synthesize timer;


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
	timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarUp:) userInfo:nil repeats:YES];	
}

- (IBAction)downButton:(id)sender
{
	
	timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAvatarDown:) userInfo:nil repeats:YES];	

}

- (IBAction)stopTimerButton:(id)sender
{
	if (timer != nil) 
		[timer invalidate];
	timer = nil;
}

- (IBAction)fireButton:(id)sender
{
	CGPoint pos = playerOnePos;
	
	NSLog(@"cgpoint pos %@",NSStringFromCGPoint(pos));

}

- (IBAction)exitGame:(id)sender
{
	
}

#pragma mark avatar movements

- (void) moveAvatarUp:(id)sender 
{
	NSLog(@"up");
	
	[UIView beginAnimations:nil context:NULL];
		
	CGPoint pos = mountOneView.center;
	
	if (pos.y - 5.0f > 100.0f) {
		pos.y -= 5.0f;
	}
	
	NSLog(@"current pos y: %f x:%f",pos.y,pos.x);
	mountOneView.center = pos;
	playerOnePos = pos;
	
	[UIView commitAnimations];	
}

- (void) moveAvatarDown:(id)sender 
{
	NSLog(@"down");
	
	[UIView beginAnimations:nil context:NULL];
		
	CGPoint pos = mountOneView.center;
	
	if (pos.y + 5.0f < 260.0f) {
		pos.y += 5.0f;
	}
	NSLog(@"current pos y: %f x:%f",pos.y,pos.x);
	mountOneView.center = pos;
	playerOnePos = pos;

	[UIView commitAnimations];	
}

- (void) randomLocationAvatar
{
	[UIView beginAnimations:nil context:NULL];	
	
	CGPoint pos = mountOneView.center;
	
	pos.y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	pos.x = 60.0f;
	NSLog(@"starting pos y: %f x:%f",pos.y,pos.x);
	mountOneView.center = pos;
	playerOnePos = pos;	
	
	[UIView commitAnimations];

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg01.png"]];
	
	CGFloat size = 80.0f;
	CGRect rect = CGRectMake((320.0f - size) / 2.0f , size + 10.0f, size, size);
	mountOneView = [[[Mount alloc] initWithFrame:rect] autorelease];
	mountOneView.backgroundColor = [UIColor redColor];
	
	//self.backgroundColor = [UIColor blackColor];
	
	[self.view addSubview:mountOneView];	
	
	[self randomLocationAvatar];
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
