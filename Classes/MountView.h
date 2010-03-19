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
    
    CGPoint offsets;
}

@property (nonatomic, retain) Mount *mMount;
@property (nonatomic, retain) MuzzleView *mMuzzleView;
@property CGPoint offsets;

- (void) moveUpMount;
- (void) moveDownMount;
- (void) setRandomLocation;

@end
