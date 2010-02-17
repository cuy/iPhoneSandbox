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

+ (Missile *) initMissile
{
	CGFloat size = 20.0f;
	CGRect rect = CGRectMake(500.0f,0, size, size);
	Missile *missileView = [[Missile alloc] initWithFrame:rect];
	missileView.backgroundColor = [UIColor blackColor];
	missileView.hidden =YES;
	return missileView;
}

- (void) fireMissileFrom: (Mount *)mountView
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
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
	
}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished {
	NSLog(@"animationDidStop %@",[animation valueForKey:@"name"]);
	if ([[animation valueForKey:@"name"] isEqual:@"fireMissile"]) {
		//self.hidden = YES;
	}
}

@end
