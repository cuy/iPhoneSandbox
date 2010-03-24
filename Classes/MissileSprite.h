//
//  MissileSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/17/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"


@interface Missile : CCSprite {

	CGPoint cposition;
	NSTimer *mTimer;
	CGFloat angle;
	CGFloat time;
}

@property CGFloat angle;

- (void) firemissile;

@end
