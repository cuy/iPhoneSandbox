//
//  MissileSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 4/14/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MissileSprite.h"
#import "cocos2d.h"


@implementation Missile

@synthesize angle, velocity;

+ (id) missileWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id) initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
		
	}
	
	return self;
}

- (void) launchMissile
{
	time = 0;
	self.rotation = angle;
	startPosition.x = self.position.x + cos(angle * M_PI/180); 
	startPosition.y = self.position.y + sin(angle * M_PI/180);
	//NSLog(@"startposition x: %f y: %f",startPosition.x,startPosition.y);
	oldPosition = startPosition;
	[self schedule:@selector(startLaunchMissile)];

}

- (void) startLaunchMissile
{
	time += (float)1/10;

	float gravity = -10;
	
	CGPoint position;
	position.x = velocity * time * cos(angle * M_PI/180) + startPosition.x;
	position.y = 0.5 * gravity * time * time - velocity * time * sin((angle * M_PI)/180) + startPosition.y;
	
	//NSLog(@"current position x: %f y: %f",position.x,position.y);
	
	self.position = position;
	
	CGFloat rot = atan2(position.y - oldPosition.y, position.x - oldPosition.x)*180.0/M_PI;
	//NSLog(@"rot %f", rot);
	self.rotation = rot * -1;
	oldPosition = position;
	if (self.position.y >= 380.0f  || self.position.x >= 530.0f || self.position.y < -15)
	{
		[self unschedule:@selector(startLaunchMissile)];
	}
	
}

@end
