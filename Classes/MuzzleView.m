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

- (id)initWithFrame:(CGRect)frame forPlayer:(int) player {
	position.x = 0;
	position.y = 0;
	mPlayer = player;
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

- (void) rotateAngle: (CGFloat) angle
{
	self.transform = CGAffineTransformMakeRotation((angle*M_PI)/180);
}


- (CGImageRef) loadImage:(NSString *)filename 
{ 
	UIImage *img = [UIImage imageNamed:filename]; 
	CGImageRef image = CGImageRetain(img.CGImage); 
	return image; 
} 

// draw 
- (void) drawImage:(CGContextRef)context pos:(CGPoint)pos image: 
(CGImageRef)image 
{ 
	//image. 
	CGRect imageRect; 
	size_t h = CGImageGetHeight( image ); 
	size_t w = CGImageGetWidth( image ); 
	imageRect.origin = CGPointMake(pos.x, pos.y);
	imageRect.size = CGSizeMake(w, h); 
    NSLog(@"imagerect = %@", CGRectCreateDictionaryRepresentation(imageRect));
	CGContextDrawImage( context, CGRectMake( pos.x, pos.y, w, h), 
					   image ); 
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	//NSLog(@"drawrect muzzleview");
    NSLog(@"drawrect @ point = %@", CGPointCreateDictionaryRepresentation(position));
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawImage:context pos:CGPointMake( position.x, position.y ) 
			  image:[self loadImage:@"angleControl.png"]]; 
	
//	self.transform = CGAffineTransformMakeRotation(180*M_PI/180);
}


- (void)dealloc {
    [super dealloc];
}


@end
