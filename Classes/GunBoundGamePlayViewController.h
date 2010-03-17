//
//  GunBoundGamePlayViewController.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Mount;
@class MountView;
@class Missile;
@class MissileView;
@class MuzzleView;

@interface GunBoundGamePlayViewController : UIViewController {
	
	// Avatar Variables
	MountView *mMountView;
	MountView *mEnemyMountView;
	MissileView *mMissileView;
	int mPower;
	IBOutlet UILabel *angleLabel;
	IBOutlet UIView *powerBar;
	IBOutlet UIButton *powerButton;
	
	// Players Variables
	MountView *mMountView1;
	MountView *mMountView2;
	
	// touch vars
	CGPoint mGestureStartPoint;
	
	NSTimer *mTimer;
	
	//btn ref
	id btnFire;
    
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
	
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;

- (void) changePlayer;

- (IBAction) stopTimerButton:(id)sender;
- (IBAction) fireButton:(id)sender;
- (IBAction) fireMissile:(id)sender;
- (IBAction) exitGame:(id)sender;

@end
