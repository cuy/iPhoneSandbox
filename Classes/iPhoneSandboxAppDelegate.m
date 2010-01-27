//
//  iPhoneSandboxAppDelegate.m
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 1/27/10.
//  Copyright Home 2010. All rights reserved.
//

#import "iPhoneSandboxAppDelegate.h"


@implementation iPhoneSandboxAppDelegate

@synthesize window;
@synthesize tabBarController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    // create tab bar controller
    UITabBarController *aTabBarController = [[UITabBarController alloc] init];
    [self setTabBarController:aTabBarController];
    [aTabBarController release];

    // Create/allocate view controllers for each tab
    UITableViewController *aMainViewController = [[UITableViewController alloc] init];
    [[aMainViewController tableView] setDataSource:self];
    UITabBarItem *aMainViewItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"32-iphone" ofType:@"png"]] tag:0];
    [aMainViewController setTabBarItem:aMainViewItem];
    [aMainViewItem release];
    [aMainViewController setTitle:@"Main"];
    UINavigationController *aMainNavigationController = [[UINavigationController alloc] initWithRootViewController:aMainViewController];
    [aMainViewController release];
    [[aMainNavigationController navigationBar] setBarStyle:UIBarStyleBlack];
    
    UITableViewController *anOptionsViewController = [[UITableViewController alloc] init];
    UITabBarItem *anOptionsViewItem = [[UITabBarItem alloc] initWithTitle:@"Options" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"19-gear" ofType:@"png"]] tag:0];
    [anOptionsViewController setTabBarItem:anOptionsViewItem];
    [anOptionsViewItem release];
    [anOptionsViewController setTitle:@"Options"];
    UINavigationController *anOptionsNavigationController = [[UINavigationController alloc] initWithRootViewController:anOptionsViewController];
    [anOptionsViewController release];
    [[anOptionsNavigationController navigationBar] setBarStyle:UIBarStyleBlack];
    
    UITableViewController *aStoreViewController = [[UITableViewController alloc] init];
    [[aStoreViewController tableView] setDataSource:self];
    UITabBarItem *aStoreViewItem = [[UITabBarItem alloc] initWithTitle:@"Store" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"35-shopping-bag" ofType:@"png"]] tag:0];
    [aStoreViewController setTabBarItem:aStoreViewItem];
    [aStoreViewItem release];
    [aStoreViewController setTitle:@"Store"];
    UINavigationController *aStoreNavigationController = [[UINavigationController alloc] initWithRootViewController:aStoreViewController];
    [aStoreViewController release];
    [[aStoreNavigationController navigationBar] setBarStyle:UIBarStyleBlack];
    
    // assign and retain view controllers to tab view controller
    [tabBarController setViewControllers:[NSArray arrayWithObjects:aMainNavigationController, anOptionsNavigationController, aStoreNavigationController, nil] animated:NO];
    
    // release view controllers for each tab
    [aMainNavigationController release];
    [anOptionsNavigationController release];
    [aStoreNavigationController release];
    
    // set selected index
    [tabBarController setSelectedIndex:0];

    [window addSubview:[tabBarController view]];
	
    [window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"iPhoneSandbox.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
	[window release];
    [tabBarController release];
	[super dealloc];
}

#pragma mark -
#pragma mark Mini-apps

- (NSArray *)miniApps
{
    if (miniApps != nil) {
        return miniApps;
    }
        
    miniApps = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mini-apps" ofType:@"plist"]];
    return miniApps;
}

#pragma mark -
#pragma mark TableView delegate

#pragma mark -
#pragma mark TableView datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // same cells are used for main & store
    if ([[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        UITableViewCell *appCell = [tableView dequeueReusableCellWithIdentifier:@"MiniAppCell"];
        if (appCell == nil) {
            appCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MiniAppCell"] autorelease];
            [appCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        
        [[appCell textLabel] setText:[[miniApps objectAtIndex:[indexPath row]] objectForKey:@"name"]];
        [[appCell imageView] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"]]];
        return appCell;
    }
    // options uses different cells
    else {
        UITableViewCell *optCell = [tableView dequeueReusableCellWithIdentifier:@"OptCell"];
        if (optCell == nil) {
            optCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OptCell"] autorelease];
        }
        
        return optCell;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.miniApps count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end

