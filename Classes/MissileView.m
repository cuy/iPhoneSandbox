//
//  MissileView.m
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 2/26/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MissileView.h"
#import "Missile.h"
#import "MountView.h"
#import "Mount.h"

@implementation MissileView

@synthesize mMissile;
@synthesize mTimer;
@synthesize mPower;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void) fireMissileFrom:(MountView *)mountView
{
	mMissile = [[Missile alloc] init];
	
	// set missile starting point
	CGPoint mPos = mountView.center;
	if (mountView.mMount.player == 1) {
		mPos.x += 20;
	}
	else {
		mPos.x -= 40;
	}
	mMissile.position = mPos;

	NSLog(@"player %d",mountView.mMount.player);
	//mMissile.angle = (float)(arc4random()%(90 - 1 + 1))+ 1;
	//mMissile.angle = 80;
	mMissile.angle =  mountView.mMount.angle;
	
	/**
	if (mountView.mMount.player == 2) {
		mMissile.angle = 180 - mMissile.angle;
	}
	 */
	
	NSLog(@"current angle: %f",mMissile.angle);
	mMissile.velocity = mPower;
	mMissile.gravity = 10;
	mMissile.time = 0;
	
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0  target:self selector:@selector(startFireMissile) userInfo:nil repeats:YES];	

}

- (void) startFireMissile
{
	[mMissile update];
	[self setNeedsDisplay];
	
	if (mMissile.position.y >= 320.0f  || mMissile.position.x >= 480.0f) {
		[mTimer invalidate];
		mTimer = nil;
		self.hidden = YES;
		//[mMissile release];
	}
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
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawImage:context pos:CGPointMake( mMissile.position.x, mMissile.position.y ) 
			  image:[self loadImage:@"missile.png"] ]; 
}

- (void)dealloc {
    [super dealloc];
}


@end
