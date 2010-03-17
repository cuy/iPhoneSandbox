//
//  GunboundMainMenuViewController.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 1/28/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GunboundMainMenuViewController : UIViewController {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;

- (IBAction)exit:(id)sender;
- (IBAction)newGameButton:(id)sender;

@end
