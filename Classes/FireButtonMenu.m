//
//  FireButton.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 4/12/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "FireButtonMenu.h"
#import "cocos2d.h"


@implementation FireButton

@synthesize powerMeter;

- (void) addPower:(ccTime) dt
{
	if (power < 105) {
		powerMeter.scaleX = power++;
		NSLog(@"power: %f",power);
	}
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"touch began");
	power = 1;
	powerMeter.scaleX = power;
	
	// start scheduler
	[self schedule:@selector(addPower:)];
	
	if( state != kMenuStateWaiting ) return NO;
	
	selectedItem = [self itemForTouch:touch];
	[selectedItem selected];
	
	if( selectedItem ) {
		state = kMenuStateTrackingTouch;
		return YES;
	}
	return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"touch ended");
	// unschedule timer
	[self unschedule:@selector(addPower:)];	
	
	NSAssert(state == kMenuStateTrackingTouch, @"[Menu ccTouchEnded] -- invalid state");
	
	[selectedItem unselected];
	//[selectedItem activate];
	
	state = kMenuStateWaiting;
}

-(CCMenuItem *) itemForTouch: (UITouch *) touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	for( CCMenuItem* item in children_ ) {
		CGPoint local = [item convertToNodeSpace:touchLocation];
		
		CGRect r = [item rect];
		r.origin = CGPointZero;
		
		if( CGRectContainsPoint( r, local ) )
			return item;
	}
	return nil;
}

@end
