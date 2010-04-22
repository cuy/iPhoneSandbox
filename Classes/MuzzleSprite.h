//
//  MuzzleSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Muzzle : CCSprite {

	float power;
	float angle;
}

@property (nonatomic) float power;
@property (nonatomic) float angle;

@end
