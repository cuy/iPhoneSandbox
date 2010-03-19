//
//  MuzzleView.m
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 3/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MuzzleView.h"


@implementation MuzzleView

@synthesize position;
@synthesize initialAngle;

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)key {
	id<CAAction> animation = nil;
	if([key isEqualToString:@"position"]) {
		animation = [CABasicAnimation animation];
		((CABasicAnimation*)animation).duration = 0.1;
	} else {
		animation = [super actionForLayer:layer forKey:key];
	}
	return animation;
}

- (id)initWithFrame:(CGRect)frame forPlayer:(int)player {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        // TODO: What's the use of position if it isn't modified?
        position.x = 0;
        position.y = 0;
        mPlayer = player;
    }
    return self;
}

- (void)rotateAngle:(CGFloat)angle
{
	self.transform = CGAffineTransformMakeRotation((angle*M_PI)/180);
}


- (CGImageRef)loadImage:(NSString *)filename 
{ 
    // TODO: Find out if this causes extra retain counts when called multiple times
	UIImage *img = [UIImage imageNamed:filename]; 
	CGImageRef image = CGImageRetain(img.CGImage); 
	return image; 
} 

- (void)drawImage:(CGContextRef)context pos:(CGPoint)pos image:(CGImageRef)image 
{ 
	//image. 
	CGRect imageRect; 
	size_t h = CGImageGetHeight(image); 
	size_t w = CGImageGetWidth(image); 
	imageRect.origin = position;
	imageRect.size = CGSizeMake(w, h); 
	CGContextDrawImage(context, CGRectMake(pos.x, pos.y, w, h), image); 
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawImage:context pos:position image:[self loadImage:@"angleControl.png"]]; 
}

- (void)dealloc {
    [super dealloc];
}


@end
