//
//  MuzzleView.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 3/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MuzzleView : UIView {

	CGPoint position;
	int mPlayer;
}

@property CGPoint position;

- (id)initWithFrame:(CGRect)frame forPlayer:(int) player;
- (void) rotateAngle: (CGFloat) angle;

@end
