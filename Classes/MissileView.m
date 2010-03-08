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
@synthesize mPower;
@synthesize cx;
@synthesize cy;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
	// set missile image as background
	mMissileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"missile2.png"]];
	[self addSubview:mMissileImageView];
	self.backgroundColor = [UIColor clearColor];
	
	// initialize mMissile
	mMissile = [[Missile alloc] init];
	CGPoint pos;
	pos.x = 0; pos.y = 0;
	mMissile.position = pos;
	
	return self;
}

- (void) fireMissileFrom:(MountView *)mountView toEnemyMountView:(MountView *)enemyMountView 
{
	mMountView = mountView;
	mEnemyMountView = enemyMountView;
	cx = mMountView.center.x;
	cy = mMountView.center.y;
	
	// set missile starting point
	//CGPoint mPos = mMountView.center;
	if (mMountView.mMount.player == 1) {
		cx += 30;
		cy += 5;
	}
	else {
		cx -= 30;
		cy += 5;
	}
	
	//mMissile.position = mPos;
	
	// rotate missile with given angle
	//self.transform = CGAffineTransformMakeRotation(((mMissile.angle - (mMissile.angle * 2)) * M_PI)/180);
	
	//mMissile.velocity = mPower;
	mMissile.gravity = 10;
	mMissile.time = 0;
	
	mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0  target:self selector:@selector(startFireMissile) userInfo:nil repeats:YES];	

}

- (void) startFireMissile
{
	// launch missile
	mMissile.time += 1.0/6.0;
	//NSLog(@"velocity: %f gravity: %f angle: %f time: %f",velocity,gravity,angle,time);
	CGPoint position = mMissile.position;
	position.x = mMissile.velocity * mMissile.time * cos(mMissile.angle * M_PI/180) + cx;
	position.y = 0.5 * mMissile.gravity * mMissile.time * mMissile.time - mMissile.velocity * mMissile.time * sin((mMissile.angle * M_PI)/180) + cy;	
	self.transform = CGAffineTransformMakeRotation(mMissile.angle*-1);
	//NSLog(@"Missile Angle = %f",atan2(position.y,position.x)*180/M_PI);
	//NSLog(@"cx = %f, cy = %f", mMissile.position.x, mMissile.position.y);
	self.center = position;
	mMissile.position = position;	
	
	//[self setNeedsDisplay];
	
	//NSLog(@"missile position x: %f y: %f",mMissile.position.x,mMissile.position.y);
	if ((mMissile.position.y >= 320.0f  || mMissile.position.x >= 480.0f) || [self didHitEnemyMountView]) {
		[mTimer invalidate];
		mTimer = nil;
		self.hidden = YES;
	}
}

- (BOOL) didHitEnemyMountView
{
	if (CGRectIntersectsRect(self.frame, mEnemyMountView.frame)) {
		NSLog(@"naka igo ka brad!");
		return YES;
	}
	else {
		return NO;
	}

}

- (void)dealloc {
    [super dealloc];
	
	[mMissile release];
}


@end
