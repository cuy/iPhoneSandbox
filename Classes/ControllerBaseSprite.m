//
//  ControllerBaseSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "ControllerBaseSprite.h"
#import "cocos2d.h"

@implementation ControllerBase

- (id) initWithImage: (NSString *) filename
{
	CCSprite *image = [CCSprite spriteWithFile:filename rect:CGRectMake(0, 0, 237, 99)];
	image.position = ccp(235,73);
	return image;
}

@end
