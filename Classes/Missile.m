//
//  Missile.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/10/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "Missile.h"
#import <QuartzCore/QuartzCore.h>


@implementation Missile

@synthesize mVelocity,mGravity,mAngle,mTime;
@synthesize mTimer;
@synthesize mMountView;

/*
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
	id<CAAction> animation = nil;
	if([key isEqualToString:@"position"]) {
		animation = [CABasicAnimation animation];
		((CABasicAnimation*)animation).duration = 1.0f;
	} else {
		animation = [super actionForLayer:layer forKey:key];
	}
	return animation;
}
*/
/*
- (id) init
{
	[super init];
	mVelocity = 10.0f;
	mGravity = 10.0f;
	mAngle = 1.0f;
	mTime = 0.0f;
	return self;
}
*/

+ (Missile *) initMissile
{
	CGFloat size = 20.0f;
	CGRect rect = CGRectMake(500.0f,0, size, size);
	Missile *missileView = [[Missile alloc] initWithFrame:rect];
	missileView.backgroundColor = [UIColor blackColor];
	missileView.hidden = YES;
	return missileView;
}

- (void) fireMissileFrom: (Mount *)mountView
{
/*	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"fireMissile" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:mountView.center]];
	
	CGPoint pos = mountView.center;
	pos.x = 450.0f;
	[animation setRemovedOnCompletion:YES];
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:1.5f];
	
    [[self layer] addAnimation:animation forKey:@"fireMissile"];
	
	NSLog(@"missile pos y: %f x:%f",mountView.center.y,mountView.center.x);
*/
	
	mVelocity = 0.1f;
	mGravity = 0.001f;
	mAngle = 1.0f;
	mTime = 0.0f;
	
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30.0f target:self selector:@selector(startFireMissile) userInfo:nil repeats:YES];	
	//[self startFireMissile];
}

- (void) startFireMissile
{
	
	CGPoint pos = self.center;
	NSLog(@"velocity: %f gravity: %f angle: %f",mVelocity,mGravity,mAngle);
	//pos.x = 100.0f;
	//pos.y = 100.0f;
	pos.x = mVelocity * mTime * cos(mAngle * (M_PI/180)) + self.center.x;
	pos.y = (mGravity * (mTime * mTime)) - ((mVelocity * mTime) * sin(mAngle * (M_PI/180))) + self.center.y;	
	NSLog(@"pos.x %f pos.y %f mtime: %f",pos.x,pos.y,mTime);
	self.center = pos;
	
	//mTime += 1.0f/30.f;
	mTime +=1.0f;
	if (mTime >= 3) {
		[mTimer invalidate];
		mTimer = nil;
	}
	
}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished {
	NSLog(@"animationDidStop %@",[animation valueForKey:@"name"]);
	if ([[animation valueForKey:@"name"] isEqual:@"fireMissile"]) {
		//self.hidden = YES;
	}
}

@end
