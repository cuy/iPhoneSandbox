//
//  MountView.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 3/2/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Mount;
@class MuzzleView;

@interface MountView : UIView {

	Mount *mMount;
	MuzzleView *mMuzzleView;
	
	CGPoint mGestureStartPoint;
}

@property (nonatomic, retain) Mount *mMount;
@property (nonatomic, retain) MuzzleView *mMuzzleView;

//+ (Mount *) initMountWithMuzzle: (MountMuzzle *)mountMuzzle;
- (id)initWithFrame:(CGRect)frame withMount:(Mount *)mount;
- (void) moveUpMount;
- (void) moveDownMount;
- (void) setRandomLocation;

@end
