//
//  GunBoundGamePlayViewController.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GunBoundGamePlayViewController.h"
#import "Mount.h"
#import "Missile.h"

#define degreesToRadian(x) (M_PI * x / 180.0)


@implementation GunBoundGamePlayViewController

@synthesize mountOneView;
@synthesize missileOneView;
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
	missileOneView.hidden = NO;
	[self fireMissile];
}

- (IBAction)exitGame:(id)sender
{
	
}

#pragma mark avatar movements

- (void) moveAvatarUp:(id)sender 
{
	NSLog(@"up");
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"moveAvatarUp" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:mountOneView.center]];
	
	CGPoint pos = mountOneView.center;
	
	if (pos.y - 5.0f > 60.0f) {
		pos.y -= 5.0f;
	}	
	
	mountOneView.center = pos;
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:0.5f];
	
    [[mountOneView layer] addAnimation:animation forKey:@"moveAvatarUp"];
}

- (void) moveAvatarDown:(id)sender 
{
	NSLog(@"down");
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"moveAvatarDown" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:mountOneView.center]];
	
	CGPoint pos = mountOneView.center;
	
	if (pos.y + 5.0f < 260.0f) {
		pos.y += 5.0f;
	}
	
	mountOneView.center = pos;
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:0.5f];
	
    [[mountOneView layer] addAnimation:animation forKey:@"moveAvatarDown"];
}

- (void) fireMissile
{
		
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"fireMissile" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:mountOneView.center]];

	CGPoint pos = mountOneView.center;
	pos.x = 400.0f;
	
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:1.5f];
	
    [[missileOneView layer] addAnimation:animation forKey:@"fireMissile"];
	
	NSLog(@"missile pos y: %f x:%f",missileOneView.center.y,missileOneView.center.x);
		
}

- (void) randomLocationAvatar
{
	[UIView beginAnimations:nil context:NULL];	
	
	CGPoint pos = mountOneView.center;
	
	pos.y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	pos.x = 60.0f;
	NSLog(@"starting pos y: %f x:%f",pos.y,pos.x);
	mountOneView.center = pos;
	
	[UIView commitAnimations];

}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished {
	NSLog(@"animationDidStop %@",[animation valueForKey:@"name"]);
	if ([[animation valueForKey:@"name"] isEqual:@"fireMissile"]) {
		missileOneView.hidden = YES;
	}
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg01.png"]];
	
	// add missile
	CGFloat size = 30.0f;
	CGRect rect = CGRectMake((320.0f - size) / 2.0f , size + 10.0f, size, size);
	missileOneView = [[Missile alloc] initWithFrame:rect];
	missileOneView.backgroundColor = [UIColor blackColor];
	//missileOneView.center = playerOnePos;
	missileOneView.hidden =YES;
	[self.view addSubview:missileOneView];
	
	// add mount
	size = 80.0f;
	rect = CGRectMake((320.0f - size) / 2.0f , size + 10.0f, size, size);
	mountOneView = [[[Mount alloc] initWithFrame:rect] autorelease];
	mountOneView.backgroundColor = [UIColor redColor];
		
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
