//
//  MountSprite.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MountSprite.h"
#import "cocos2d.h"


@implementation Mount

@synthesize mMuzzle, enabled;

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

+ (id)mountWithTexture:(CCTexture2D *)aTexture
{
	return [[[self alloc] initWithTexture:aTexture] autorelease];
}

- (id)initWithTexture:(CCTexture2D *)aTexture
{
	if ((self = [super initWithTexture:aTexture]) ) {
		
		state = kMountStateUngrabbed;
	}
	
	return self;
}

- (void) setRandomLocationForPlayer:(int) player
{
	CGFloat y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	CGFloat x = 50;
	if (player == 2) {
		x = 430;
		// flip player image
		self.scaleX = -self.scaleX;
	}
	self.position = ccp(x, y);
}

- (void) setMuzzleLocationForPlayer:(int) player
{	
	CGFloat x = self.position.x + 30;
	CGFloat y = self.position.y - 9;
	if (player == 2) {
		x -= 60;
		// flip muzzle image
		self.mMuzzle.scaleX = -self.mMuzzle.scaleX;
		//self.mMuzzle.flipX = YES;
		NSLog(@"scale x %f",self.mMuzzle.scaleX);
	}
	self.mMuzzle.position = ccp(x,y);
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
	if (state != kMountStateUngrabbed) return NO;
	if ( ![self containsTouchLocation:touch] ) return NO;
	
	state = kMountStateGrabbed;
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
	
	NSAssert(state == kMountStateGrabbed, @"Mount - Unexpected state!");	
	
	if (enabled) {
		CGPoint touchPoint = [touch locationInView:[touch view]];
		touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
		
		if (touchPoint.y <= 280 && touchPoint.y >= 30) {
			self.position = CGPointMake(self.position.x, touchPoint.y);
			mMuzzle.position = CGPointMake(mMuzzle.position.x, self.position.y - 9);
		}
	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state == kMountStateGrabbed, @"Mount - Unexpected state!");	
	
	state = kMountStateUngrabbed;
}

@end
