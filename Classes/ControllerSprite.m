//
//  ControllerBaseSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "ControllerSprite.h"
#import "cocos2d.h"

@implementation Controller

@synthesize fireButton;

+ (id) controllertWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id) initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
		
	}
	
	return self;
}


@end
