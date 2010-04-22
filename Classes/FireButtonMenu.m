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
@synthesize delegate;


- (void) addPower:(ccTime) dt
{
	if (power < 105) {
		power = power + 2;
		powerMeter.scaleX = power;
		//NSLog(@"power: %f",power);
	}
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{

	if( state != kMenuStateWaiting ) return NO;
	
	selectedItem = [self itemForTouch:touch];
	[selectedItem selected];
	
	if( selectedItem ) {
		state = kMenuStateTrackingTouch;
		
		// re-initialize power and power Meter
		power = 1;
		powerMeter.scaleX = power;
		
		// start scheduler
		[self schedule:@selector(addPower:)];
		
		return YES;
	}
	return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"touch ended");
	// unschedule timer
	[self unschedule:@selector(addPower:)];
		
	// launch missile
	[[self delegate] launchMissileWithPower: power];
	//change player
	[[self delegate] changePlayer];
	

	
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
