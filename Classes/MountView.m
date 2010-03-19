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
@synthesize offsets;

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
	
	CGRect defaultFrame = CGRectMake(0,0,65,58);
    if (self = [super initWithFrame:defaultFrame]) {
        // Initialization code
        
        // initialize Mount model
        mMount = [[Mount alloc] init];        
        mMount.player = player;
        self.backgroundColor = [UIColor clearColor];
        
        // initialize the MuzzleView
        MuzzleView *aMuzzleView = [[MuzzleView alloc] initWithFrame:CGRectMake(0, 0, 75, 75) forPlayer:mMount.player];
        [self setMMuzzleView:aMuzzleView];
        [aMuzzleView release];
    }
	
    return self;
}

- (void)layoutSubviews {
    [mMuzzleView removeFromSuperview];
    CGRect newFrame = CGRectMake(self.center.x + offsets.x, self.center.y + offsets.y, 75, 75);
    [mMuzzleView setFrame:newFrame];
    [self.superview insertSubview:mMuzzleView belowSubview:self];
    [mMuzzleView rotateAngle:mMuzzleView.initialAngle];
}


- (void)moveUpMount {
	CGPoint pos = self.center;
	CGPoint muzzlepos = mMuzzleView.center;

	if (pos.y - 5.0f > 60.0f) {
		pos.y -= 5.0f;
		muzzlepos.y -= 5.0f; 
	}
	
	self.center = pos;
	mMuzzleView.center = muzzlepos;
}

- (void)moveDownMount {
	CGPoint pos = self.center;
	CGPoint muzzlepos = mMuzzleView.center;

	if (pos.y + 5.0f < 260.0f) {
		pos.y += 5.0f;
		muzzlepos.y += 5.0f; 
	}
	
	self.center = pos;
	mMuzzleView.center = muzzlepos;
}

- (void)setRandomLocation {	
	CGPoint pos = self.center;
	
	if (mMount.player == 1) {
		pos.x = 50.0f;
	}
	else {
		pos.x = 430.0f;
	}
	
	pos.y = (float)(arc4random()%(250 - 50 + 1))+ 50;
	self.center = pos;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:self];
	
	if (currentPosition.y <= mGestureStartPoint.y) 
	{
		[self moveDownMount];
	}
	else if (currentPosition.y >= mGestureStartPoint.y) 
	{
		[self moveUpMount];
	}
}

- (CGImageRef) loadImage:(NSString *)filename { 
	UIImage *img = [UIImage imageNamed:filename]; 
	CGImageRef image = CGImageRetain(img.CGImage); 
	return image; 
} 

- (void)drawImage:(CGContextRef)context pos:(CGPoint)pos image:(CGImageRef)image { 
	CGRect imageRect; 
	size_t h = CGImageGetHeight(image); 
	size_t w = CGImageGetWidth(image); 
	imageRect.origin = pos; 
	imageRect.size = CGSizeMake(w, h); 
	CGContextDrawImage(context, CGRectMake( pos.x, pos.y, w, h), image); 
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawImage:context pos:mMount.position image:[self loadImage:[NSString stringWithFormat:@"player_%d.png",mMount.player]]]; 	
    // TODO: Why is image upside down without this transform?
	self.transform = CGAffineTransformMakeRotation(180*M_PI/180);
}

- (void)dealloc {
    [super dealloc];
	
	[mMount release];
	[mMuzzleView release];
}

@end
