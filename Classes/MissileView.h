//
//  MissileView.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 2/26/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Missile;
@class Mount;

@interface MissileView : UIView {

	Missile *mMissile;
	NSTimer *mTimer;
}

@property (nonatomic, retain) Missile *mMissile;
@property (nonatomic, retain) NSTimer *mTimer;

- (void) fireMissileFrom: (Mount *) mountView;
- (void) startFireMissile;

@end
