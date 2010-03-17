//
//  GunboundMainMenuViewController.m
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 1/28/10.
//  Copyright 2010 Home. All rights reserved.
//

#import "GunboundMainMenuViewController.h"
#import "GunBoundNewCharacterViewController.h"
#import "GunBoundGamePlayViewController.h"
#import "User.h"


@implementation GunboundMainMenuViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSEntityDescription *userEntity = [[managedObjectModel entitiesByName] objectForKey:@"User"];
    NSFetchRequest *usersRequest = [[NSFetchRequest alloc] init];
    [usersRequest setEntity:userEntity];
    
    NSError *error = nil;
    
    NSArray *users = [managedObjectContext executeFetchRequest:usersRequest error:&error];
    if ((error != nil) || (users == nil)) {
        NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
    
    if ([users count] == 0) {
        // add a default user
        User *defaultUser = [[User alloc] initWithEntity:userEntity insertIntoManagedObjectContext:[self managedObjectContext]];
        [defaultUser setName:@"Default User"];
        error = nil;
        [managedObjectContext save:&error];
        if (error != nil) {
            NSLog(@"Error while saving\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
        
    }
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

#pragma mark -
#pragma mark View appear/disappear

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark -
#pragma mark Temporary actions

- (IBAction)exit:(id)sender
{
    [[self navigationController] popViewControllerAnimated:NO];
}

- (IBAction)newGameButton:(id)sender
{
	// if new user then create character
	
	//GunBoundNewCharacterViewController *viewController = [[GunBoundNewCharacterViewController alloc] initWithNibName:@"GunBoundNewCharacterViewController" bundle:[NSBundle mainBundle]];
	GunBoundGamePlayViewController *viewController = [[GunBoundGamePlayViewController alloc] initWithNibName:@"GunBoundGamePlayViewController" bundle:[NSBundle mainBundle]];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; // this is a leak!
	window.backgroundColor = [UIColor redColor]; // just for debugging
	[UIView setAnimationsEnabled:NO];
	[window addSubview:viewController.view];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
	[window makeKeyAndVisible];
	//[self.navigationController pushViewController:viewController animated:YES];
	//[self.view addSubview:viewController.view];
	//[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];

	//[viewController release];
	
	// else start game
	// to be filled soon
}


@end
