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

@interface MountView : UIView {

	Mount *mMount;
}

@property (nonatomic, retain) Mount *mMount;

//+ (Mount *) initMountWithMuzzle: (MountMuzzle *)mountMuzzle;
- (id)initWithFrame:(CGRect)frame withMount:(Mount *)mount;
- (void) moveUpMount;
- (void) moveDownMount;
- (void) setRandomLocation;

@end
