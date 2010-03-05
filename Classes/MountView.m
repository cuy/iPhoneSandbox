//
//  MountView.m
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 3/2/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MountView.h"
#import "Mount.h"
#import "MuzzleView.h"

@implementation MountView

@synthesize mMount;
@synthesize mMuzzleView;

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


- (id)initWithFrame:(CGRect)frame withMount:(Mount *)mount {
	mMount = mount;
	
	CGFloat x;
	if (mount.player == 1) {
		x = 20.0f;
	}
	else {
		x = 395.0f;
	}
	
	frame = CGRectMake(x,0,65,58);
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void) moveUpMount
{
	NSLog(@"moveUpMount");
	/*
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
	 */
	CGPoint pos = self.center;
	CGPoint muzzlepos = mMuzzleView.center;

	if (pos.y - 5.0f > 60.0f) {
		pos.y -= 5.0f;
		muzzlepos.y -= 5.0f; 
	}
	
	self.center = pos;
	mMuzzleView.center = muzzlepos;
	//NSLog(@"current pos x: %f y:%f",pos.x,pos.y);
}

- (void) moveDownMount
{
	NSLog(@"moveDownMount");
	/*
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
	*/
	CGPoint pos = self.center;
	CGPoint muzzlepos = mMuzzleView.center;

	if (pos.y + 5.0f < 260.0f) {
		pos.y += 5.0f;
		muzzlepos.y += 5.0f; 
	}
	
	self.center = pos;
	mMuzzleView.center = muzzlepos;
	//NSLog(@"current pos x: %f y:%f",pos.x,pos.y);
}

- (void) setRandomLocation
{	
	CGPoint pos = self.center;
	
	pos.y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	NSLog(@"starting pos x: %f y:%f",pos.x,pos.y);
	self.center = pos;
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:self];
	//NSLog(@"view position x: %f y: %f",self.center.x,self.center.y);
	NSLog(@"touch began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:self];
	NSLog(@"currentPosition x: %f y: %f",currentPosition.x,currentPosition.y);
	
	if (currentPosition.y <= mGestureStartPoint.y) 
	{
		[self moveDownMount];
	}
	else if (currentPosition.y >= mGestureStartPoint.y) 
	{
		[self moveUpMount];
	}
	NSLog(@"current view position x: %f y: %f",self.center.x,self.center.y);

	//mGestureStartPoint = currentPosition;
	
	NSLog(@"touchesmoved");
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
	CGContextDrawImage( context, CGRectMake( pos.x, pos.y, w, h), 
					   image ); 
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"drawrect mountview");
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawImage:context pos:CGPointMake( mMount.position.x, mMount.position.y ) 
			  image:[self loadImage:[NSString stringWithFormat:@"player_%d.png",mMount.player]] ]; 
	
	self.transform = CGAffineTransformMakeRotation(180*M_PI/180);
}

- (void)dealloc {
    [super dealloc];
}

@end
