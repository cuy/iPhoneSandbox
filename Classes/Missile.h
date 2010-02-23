//
//  Missile.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/10/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mount.h"

@interface Missile : UIView {
	
	CGFloat mVelocity;
	CGFloat mGravity;
	CGFloat mTime;
	CGFloat mAngle;
	
	NSTimer *mTimer;
	Mount *mMountView;
}

@property (readwrite, assign) CGFloat mVelocity;
@property (readwrite, assign) CGFloat mGravity;
@property (readwrite, assign) CGFloat mTime;
@property (readwrite, assign) CGFloat mAngle;

@property(retain, nonatomic) NSTimer *mTimer;
@property(retain, nonatomic) Mount *mMountView;


+ (Missile *) initMissile;
- (void) fireMissileFrom: (Mount *)mountView;

@end
