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

@synthesize powerMeter;

+ (id)fireButtonWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
		
		state = kFireButtonStateUngrabbed;
	}
	
	return self;
}

- (void) addPower:(ccTime) dt
{
	if (power < 105) {
		powerMeter.scaleX = power++;
		NSLog(@"power: %f",power);
	}
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (state != kFireButtonStateUngrabbed) return NO;
	if ( ![self containsTouchLocation:touch] ) return NO;
	
	state = kFireButtonStateGrabbed;
	
	// re-initialize power
	power = 1;
	powerMeter.scaleX = power;
	
	// start scheduler
	[self schedule:@selector(addPower:)];
	
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	// If it weren't for the TouchDispatcher, you would need to keep a reference
	// to the touch from touchBegan and check that the current touch is the same
	// as that one.
	// Actually, it would be even more complicated since in the Cocos dispatcher
	// you get NSSets instead of 1 UITouch, so you'd need to loop through the set
	// in each touchXXX method.
	
	NSAssert(state == kFireButtonStateGrabbed, @"Mount - Unexpected state!");	

}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kFireButtonStateGrabbed, @"Mount - Unexpected state!");	
	
	state = kFireButtonStateUngrabbed;
	
	// unschedule timer
	[self unschedule:@selector(addPower:)];	
}

@end
