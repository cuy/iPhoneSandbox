//
//  MissileSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 4/14/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Missile : CCSprite {

	CGPoint startPosition;
	CGPoint oldPosition;
	float time;
	float angle;
	float velocity;
	NSTimer *mTimer;

}

@property (nonatomic, assign) float velocity;
@property (nonatomic, assign) float angle;

+ (id) missileWithTexture:(CCTexture2D *)aTexture;
- (void) launchMissile;

@end
