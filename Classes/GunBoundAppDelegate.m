//
//  GunBoundAppDelegate.m
//  GunBound
//
//  Created by Royce Albert Dy on 3/12/10.
//  Copyright G2iX 2010. All rights reserved.
//

#import "GunBoundAppDelegate.h"
#import "GunBoundViewController.h"

@implementation GunBoundAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
