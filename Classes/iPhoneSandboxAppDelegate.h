//
//  iPhoneSandboxAppDelegate.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 1/27/10.
//  Copyright Home 2010. All rights reserved.
//

@interface iPhoneSandboxAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
    
    UITabBarController *tabBarController;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) UITabBarController *tabBarController;

- (NSString *)applicationDocumentsDirectory;

@end

