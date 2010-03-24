//
//  MountSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"
#import "MuzzleSprite.h"

typedef enum tagMountState {
	kMountStateGrabbed,
	kMountStateUngrabbed
} MountState;

@interface Mount : CCSprite <CCTargetedTouchDelegate> {

	Muzzle *mMuzzle;
	
@private
	MountState state;
}

@property(nonatomic, readonly) CGRect rect;
@property(nonatomic, retain) Muzzle *mMuzzle;

- (void) setRandomLocationForPlayer:(int) player;
- (void) setMuzzleLocationForPlayer:(int) player;
+ (id)mountWithTexture:(CCTexture2D *)texture;
@end
