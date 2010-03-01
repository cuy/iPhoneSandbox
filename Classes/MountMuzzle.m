//
//  MountMuzzle.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/17/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MountMuzzle.h"
#import <QuartzCore/QuartzCore.h>


@implementation MountMuzzle

/*
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}
*/

+ (MountMuzzle *) initMuzzle
{
	NSLog(@"initMuzzle");
	CGRect muzzlePath = CGRectMake(70.0f, 48.0f, 40.0f, 40.0f);
	CGContextAddEllipseInRect(nil,muzzlePath);
	//MountMuzzle *muzzleView = [[[MountMuzzle alloc] initWithFrame:rect] autorelease];
	MountMuzzle *muzzleView = [[[MountMuzzle alloc] initWithFrame:muzzlePath] autorelease];
	//muzzleView.backgroundColor = [UIColor redColor];
	
	//CGRect muzzleRect = CGRectMake(25.0f, 3.0f, 40.0f, 20.0f);
	CGRect muzzleRect = CGRectMake(0, 0, 25.0f, 20.0f);
	UIButton *muzzleButton = [[[UIButton alloc] initWithFrame:muzzleRect] autorelease];
	muzzleButton.backgroundColor = [UIColor blueColor];
	[muzzleView addSubview:muzzleButton];
	
	return muzzleView;
}

- (void) rotateMuzzleUp
{
	NSLog(@"rotateMuzzleup");
	/*
	CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	[rotateAnimation setDuration:1.0f];
	[rotateAnimation setValue:@"rotatemuzzleup" forKey:@"name"];
	[rotateAnimation setFromValue:[NSNumber numberWithFloat:mAngle]];
	[rotateAnimation setRemovedOnCompletion:YES];
	[rotateAnimation setFillMode:kCAFillModeForwards];
	mAngle -= 0.1f;
	[rotateAnimation setToValue:[NSNumber numberWithFloat:mAngle]];

	[self.layer addAnimation:rotateAnimation forKey:@"rotatemuzzleup"];
	*/
	if ((mAngle - 0.1f) > -0.6f) {
		mAngle -= 0.1f;
	}
	self.transform = CGAffineTransformMakeRotation(M_PI/mAngle);
	//NSLog(@"muzzle pos y: %f x:%f",self.center.y,self.center.x);
	NSLog(@"mangle %f",mAngle);

}

- (void) rotateMuzzleDown
{
	NSLog(@"rotateMuzzledown");
	/*
	CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	[rotateAnimation setDuration:1.0f];
	[rotateAnimation setValue:@"rotateMuzzledown" forKey:@"name"];
	[rotateAnimation setFromValue:[NSNumber numberWithFloat:mAngle]];
	[rotateAnimation setRemovedOnCompletion:YES];
	[rotateAnimation setFillMode:kCAFillModeForwards];
	mAngle += 0.1f;
	[rotateAnimation setToValue:[NSNumber numberWithFloat:mAngle]];
	
	[self.layer addAnimation:rotateAnimation forKey:@"rotatemuzzledown"];
	*/
	//if ((mAngle + 0.1f) < 0.4f) {
		mAngle += 0.1f;
	//}
	NSLog(@"transform a: %f",self.transform.a);
	NSLog(@"transform b: %f",self.transform.b);
	NSLog(@"transform c: %f",self.transform.c);
	NSLog(@"transform d: %f",self.transform.d);
	NSLog(@"transform tx: %f",self.transform.tx);
	NSLog(@"transform ty: %f",self.transform.ty);
	
	//self.transform.tx = 1.0f;
	//self.transform = CGAffineTransformMakeTranslation(2.0,2.0);
	//self.transform = CGAffineTransformMakeRotation(mAngle);
	self.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(10.0, 10.0), mAngle);
	//NSLog(@"muzzle pos y: %f x:%f",self.center.y,self.center.x);
	NSLog(@"mangle %f",mAngle);
}


- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)finished {
	NSLog(@"animationDidStop %@",[animation valueForKey:@"name"]);
	if ([[animation valueForKey:@"name"] isEqual:@"rotateMuzzledown"]) {
		self.transform = CGAffineTransformMakeRotation(mAngle);
	}
}

@end
