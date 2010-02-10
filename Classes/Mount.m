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

@end
