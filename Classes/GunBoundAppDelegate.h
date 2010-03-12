//
//  GunBoundAppDelegate.h
//  GunBound
//
//  Created by Royce Albert Dy on 3/12/10.
//  Copyright G2iX 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GunBoundViewController;

@interface GunBoundAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GunBoundViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GunBoundViewController *viewController;

@end

