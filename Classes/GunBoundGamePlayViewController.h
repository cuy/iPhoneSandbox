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
	MissileView *mMissileView;
	MuzzleView *mMuzzleView;
	CGFloat mAngle;
	int mPower;
	int mAccel;
	IBOutlet UILabel *powerLabel;
	IBOutlet UILabel *angleLabel;
	IBOutlet UISlider *angleSlider;
	
	// Players Variables
	MountView *mMountView1;
	MountView *mMountView2;
	Mount *mMount1;
	Mount *mMount2;
	MuzzleView *mMuzzleView1;
	MuzzleView *mMuzzleView2;
	
	// touch vars
	CGPoint mGestureStartPoint;
	
	NSTimer *mTimer;
	
}

@property(nonatomic, readonly, assign) MountView *mMountView;
@property(nonatomic, readonly, assign) MuzzleView *mMuzzleView;
@property(nonatomic, readonly, assign) MissileView *mMissileView;

@property(nonatomic, readonly, assign) MountView *mMountView1;
@property(nonatomic, readonly, assign) MountView *mMountView2;
@property(nonatomic, readonly, assign) Mount *mMount1;
@property(nonatomic, readonly, assign) Mount *mMount2;
@property(nonatomic, readonly, assign) MuzzleView *mMuzzleView1;
@property(nonatomic, readonly, assign) MuzzleView *mMuzzleView2;

@property(retain, nonatomic) NSTimer *mTimer;
@property(nonatomic, retain) IBOutlet UILabel *powerLabel;
@property(nonatomic, retain) IBOutlet UILabel *angleLabel;
@property(nonatomic, retain) IBOutlet UISlider *angleSlider;

- (void) changePlayer;


- (IBAction) upButton:(id)sender;
- (IBAction) downButton:(id)sender;
//- (IBAction)upAngleMuzzle:(id)sender;
//- (IBAction)downAngleMuzzle:(id)sender;
- (IBAction) stopTimerButton:(id)sender;
- (IBAction) fireButton:(id)sender;
- (IBAction) fireMissile:(id)sender;
- (IBAction) exitGame:(id)sender;
- (IBAction) changeAngle:(UISlider *) sender;

@end
