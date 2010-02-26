//
//  Missile.m
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 2/26/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "Missile.h"


@implementation Missile

@synthesize velocity, gravity, angle, time, position;

- (void) update
{
	NSLog(@"velocity: %f gravity: %f angle: %f time: %f",velocity,gravity,angle,time);
	position.x = velocity * time * cos(angle * (M_PI/180)) + position.x;
	position.y = (gravity * (time * time)) - ((velocity * time) * sin(angle * (M_PI/180))) + position.y;	

	NSLog(@"x: %f, y:%f", position.x, position.y);

}

@end
