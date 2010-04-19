//
//  MissileView.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 2/26/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Missile;
@class MountView;

@protocol MissileViewDelegate 

- (void)missileProjectileCompleted:(BOOL)didHitEnemy;

@end

@interface MissileView : UIView {

	UIImageView *mMissileImageView;
	Missile *mMissile;
	NSTimer *mTimer;
	CGFloat mPower;
	CGFloat cx;
	CGFloat cy;
	CGPoint position;
	CGPoint oposition;
	id <MissileViewDelegate> delegate;

	
	MountView *mMountView;
	MountView *mEnemyMountView;
}

@property (nonatomic, retain) Missile *mMissile;
@property CGFloat cx;
@property CGFloat cy;
@property CGFloat mPower;
@property CGPoint position;
@property CGPoint oposition;
@property (nonatomic, assign) id <MissileViewDelegate> delegate;

- (void) fireMissileFrom:(MountView *) mountView toEnemyMountView:(MountView *)enemyMountView;
- (void) startFireMissile;
- (BOOL) didHitEnemyMountView;

@end
