//
//  Missile.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 2/26/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Missile : NSObject {

	CGPoint position;
	CGFloat velocity;
	CGFloat gravity;
	CGFloat angle;
	CGFloat time;
}

@property CGPoint position;
@property CGFloat velocity;
@property CGFloat gravity;
@property CGFloat angle;
@property CGFloat time;

- (void) update;

@end
