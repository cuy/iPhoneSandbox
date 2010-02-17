//
//  Mount.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/10/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "Mount.h"
#import <QuartzCore/QuartzCore.h>


@implementation Mount
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

+ (Mount *) initMountWithMuzzle: (MountMuzzle *)mountMuzzle
{
	NSLog(@"initMount");
	CGFloat size = 80.0f;
	CGRect rect = CGRectMake((320.0f - size) / 2.0f , size + 10.0f, size, size);
	Mount *mountView = [[[Mount alloc] initWithFrame:rect] autorelease];
	mountView.backgroundColor = [UIColor greenColor];	
	
	//mountMuzzle = [MountMuzzle initMuzzle];
	//mountMuzzle.transform = CGAffineTransformMakeRotation (50.0f);
	[mountView addSubview:mountMuzzle];
	[mountView sendSubviewToBack:mountMuzzle];
	
	return mountView;
}

- (void) moveUpMount
{
	NSLog(@"moveUpMount");
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"moveUpMount" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:self.center]];
	
	CGPoint pos = self.center;
	
	if (pos.y - 5.0f > 60.0f) {
		pos.y -= 5.0f;
	}	
	
	self.center = pos;
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:0.5f];
	
    [[self layer] addAnimation:animation forKey:@"moveUpMount"];
}

- (void) moveDownMount
{
	NSLog(@"moveDownMount");
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDelegate:self];
	[animation setValue:@"moveDownMount" forKey:@"name"];
	[animation setFromValue:[NSValue valueWithCGPoint:self.center]];
	
	CGPoint pos = self.center;
	
	if (pos.y + 5.0f < 260.0f) {
		pos.y += 5.0f;
	}
	
	self.center = pos;
	[animation setToValue:[NSValue valueWithCGPoint:pos]];
    [animation setDuration:0.5f];
	
    [[self layer] addAnimation:animation forKey:@"moveDownMount"];	
}

- (void) setRandomLocation
{	
	CGPoint pos = self.center;
	
	pos.y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	pos.x = 60.0f;
	NSLog(@"starting pos y: %f x:%f",pos.y,pos.x);
	self.center = pos;
	
}
@end
