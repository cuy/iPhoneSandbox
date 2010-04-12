//
//  FireButton.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 4/12/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface FireButton : CCMenu {

	float power;
	CCSprite *powerMeter;
}
@property (nonatomic, retain) CCSprite *powerMeter;

-(CCMenuItem *) itemForTouch: (UITouch *) touch;

@end
