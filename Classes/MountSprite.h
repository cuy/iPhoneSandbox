//
//  MountSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"

typedef enum tagMountState {
	kMountStateGrabbed,
	kMountStateUngrabbed
} MountState;

@interface Mount : CCSprite <CCTargetedTouchDelegate> {
@private
	MountState state;
}

@property(nonatomic, readonly) CGRect rect;

+ (id)mountWithTexture:(CCTexture2D *)texture;
@end
