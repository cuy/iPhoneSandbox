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
//@class MountMuzzle;
@class Missile;
@class MissileView;

@interface GunBoundGamePlayViewController : UIViewController {
	
	// Avatar Variables
	MountView *mMountView;
	//MountMuzzle *mMountMuzzleView;
	//UIButton *mMountMuzzleButton;
	MissileView *mMissileView;
	int mPower;
	IBOutlet UILabel *powerLabel;
	
	// Players Variables
	MountView *mMountView1;
	MountView *mMountView2;
	Mount *mMount1;
	Mount *mMount2;
	
	NSTimer *mTimer;
	
}

@property(nonatomic, readonly, assign) MountView *mMountView;
//@property(nonatomic, readonly, assign) MountMuzzle *mMountMuzzleView;
@property(nonatomic, readonly, assign) MissileView *mMissileView;

@property(nonatomic, readonly, assign) MountView *mMountView1;
@property(nonatomic, readonly, assign) MountView *mMountView2;
@property(nonatomic, readonly, assign) Mount *mMount1;
@property(nonatomic, readonly, assign) Mount *mMount2;

@property(retain, nonatomic) NSTimer *mTimer;
@property(nonatomic, retain) IBOutlet UILabel *powerLabel;

- (void) changePlayer;


- (IBAction) upButton:(id)sender;
- (IBAction) downButton:(id)sender;
//- (IBAction)upAngleMuzzle:(id)sender;
//- (IBAction)downAngleMuzzle:(id)sender;
- (IBAction) stopTimerButton:(id)sender;
- (IBAction) fireButton:(id)sender;
- (IBAction) fireMissile:(id)sender;
- (IBAction) exitGame:(id)sender;

@end
