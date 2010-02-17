//
//  Mount.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/10/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MountMuzzle.h"

@interface Mount : UIView {

}

+ (Mount *) initMountWithMuzzle: (MountMuzzle *)mountMuzzle;
- (void) moveUpMount;
- (void) moveDownMount;
- (void) setRandomLocation;

@end
