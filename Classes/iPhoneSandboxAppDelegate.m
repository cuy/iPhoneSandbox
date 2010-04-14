//
//  iPhoneSandboxAppDelegate.m
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 1/27/10.
//  Copyright Home 2010. All rights reserved.
//

#import "iPhoneSandboxAppDelegate.h"
#import "GunboundMainMenuViewController.h"

#define kMiniAppKeyName @"name"
#define kMiniAppKeyImage @"imageFilename"
#define kMiniAppCell @"MiniAppCell"
#define kOptCell @"OptCell"

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
    [[aMainViewController tableView] setDelegate:self];
    UITabBarItem *aMainViewItem = [[UITabBarItem alloc] initWithTitle:@"Main" image:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"32-iphone" ofType:@"png"]] tag:0];
    [aMainViewController setTabBarItem:aMainViewItem];
    [aMainViewItem release];
    [aMainViewController setTitle:@"Main"];
    UINavigationController *aMainNavigationController = [[UINavigationController alloc] initWithRootViewController:aMainViewController];
    [aMainViewController release];
    [[aMainNavigationController navigationBar] setBarStyle:UIBarStyleBlack];
    
    UITableViewController *anOptionsViewController = [[UITableViewController alloc] init];
    [[anOptionsViewController tableView] setDataSource:self];
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
	NSLog(@"storeUrl = %@", storeUrl);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:0] topViewController] tableView] == tableView) {
        GunboundMainMenuViewController *gunboundMainMenuViewController = [[GunboundMainMenuViewController alloc] initWithNibName:@"GunboundMainMenu" bundle:nil];
        [gunboundMainMenuViewController setManagedObjectContext:[self managedObjectContext]];
        [gunboundMainMenuViewController setManagedObjectModel:[self managedObjectModel]];
        [gunboundMainMenuViewController setHidesBottomBarWhenPushed:YES];
        [(UINavigationController *)[tabBarController selectedViewController] pushViewController:gunboundMainMenuViewController animated:NO];
        [gunboundMainMenuViewController release];
    }
}

#pragma mark -
#pragma mark TableView datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // same cells are used for main & store
    // object at postion 1 is the options view
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        UITableViewCell *appCell = [tableView dequeueReusableCellWithIdentifier:kMiniAppCell];
        if (appCell == nil) {
            appCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMiniAppCell] autorelease];
            [appCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [appCell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        
        [[appCell textLabel] setText:[[self.miniApps objectAtIndex:[indexPath row]] objectForKey:kMiniAppKeyName]];
        NSArray *imageComponents = [[[self.miniApps objectAtIndex:[indexPath row]] objectForKey:kMiniAppKeyImage] componentsSeparatedByString:@"."];
        [[appCell imageView] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[imageComponents objectAtIndex:0] ofType:[imageComponents objectAtIndex:1]]]];
        return appCell;
    }
    // options uses different cells
    else {
        UITableViewCell *optCell = [tableView dequeueReusableCellWithIdentifier:kOptCell];
        if (optCell == nil) {
            optCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kOptCell] autorelease];
        }
        
        return optCell;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        return [self.miniApps count];        
    }
    else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        return 1;        
    }
    else {
        return 1;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        return NO;
    }
    else {
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(UITableViewController *)[[[tabBarController viewControllers] objectAtIndex:1] topViewController] tableView] != tableView) {
        return NO;
    }
    else {
        return NO;
    }
}

@end

