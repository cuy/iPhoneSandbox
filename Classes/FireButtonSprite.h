//
//  FireButtonSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum tagFireButtonState {
	kFireButtonStateGrabbed,
	kFireButtonStateUngrabbed
} FireButtonState;

@interface FireButton : CCSprite <CCTargetedTouchDelegate> {

	float power;
	CCSprite *powerMeter;

@private
	FireButtonState state;
	
}

@property (nonatomic, retain) CCSprite *powerMeter;

+ (id)fireButtonWithTexture:(CCTexture2D *)aTexture;

@end
