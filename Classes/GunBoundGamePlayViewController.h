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
@class MountMuzzle;
@class Missile;

@interface GunBoundGamePlayViewController : UIViewController {
	
	// Avatar Variables
	Mount *mMountView;
	MountMuzzle *mMountMuzzleView;
	UIButton *mMountMuzzleButton;
	Missile *mMissileView;
	float mAngle;
	
	NSTimer *mTimer;
	
}

@property(nonatomic, readonly, assign) Mount *mMountView;
@property(nonatomic, readonly, assign) MountMuzzle *mMountMuzzleView;
@property(nonatomic, readonly, assign) Missile *mMissileView;

@property(retain, nonatomic) NSTimer *mTimer;

- (IBAction)upButton:(id)sender;
- (IBAction)downButton:(id)sender;
- (IBAction)upAngleMuzzle:(id)sender;
- (IBAction)downAngleMuzzle:(id)sender;
- (IBAction)stopTimerButton:(id)sender;
- (IBAction)fireButton:(id)sender;
- (IBAction)exitGame:(id)sender;

@end
