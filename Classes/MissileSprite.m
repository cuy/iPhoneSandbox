//
//  MissileSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/17/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MissileSprite.h"
#import "cocos2d.h"


@implementation Missile

@synthesize angle;

- (void) firemissile
{
	
	cposition.x =  self.position.x + cos(angle); 
	cposition.y =  self.position.y + sin(angle); 
	NSLog(@"cposition x: %f y: %f",cposition.x,cposition.y);
	
	//cposition = [[CCDirector sharedDirector] convertToGL:cposition];
	time = 0;
	angle = -45;
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0  target:self selector:@selector(startFireMissile) userInfo:nil repeats:YES];	
	
}

- (void) startFireMissile
{
	CGFloat velocity = 50;
	CGFloat gravity = -10;
	// launch missile
	time += 1.0/10;
	CGPoint position;
	position.x = velocity * time * cos(angle * M_PI/180) + cposition.x;
	position.y = 0.5 * gravity * time * time - velocity * time * sin((angle * M_PI)/180) + cposition.y;	
	NSLog(@"position x: %f y: %f",position.x,position.y);
	//position = [[CCDirector sharedDirector] convertToGL:position];
	self.position = position;
	
	if (position.y >= 320.0f  || position.x >= 480.0f) {
		[mTimer invalidate];
		mTimer = nil;
	}
}

@end
