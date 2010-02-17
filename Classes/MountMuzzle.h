//
//  MountMuzzle.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/17/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MountMuzzle : UIView {
	
	float mAngle;
	
}

+ (MountMuzzle *) initMuzzle;
- (void) rotateMuzzleUp;
- (void) rotateMuzzleDown;

@end
