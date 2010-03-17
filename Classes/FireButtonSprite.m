//
//  FireButtonSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "FireButtonSprite.h"
#import "cocos2d.h"

@implementation FireButton

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchces began");
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	NSLog(@"touch position x: %f y: %f",location.x,location.y);
}

@end
