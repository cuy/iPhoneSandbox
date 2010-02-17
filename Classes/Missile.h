//
//  Missile.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/10/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mount.h"

@interface Missile : UIView {

}

+ (Missile *) initMissile;
- (void) fireMissileFrom: (Mount *)mountView;

@end
