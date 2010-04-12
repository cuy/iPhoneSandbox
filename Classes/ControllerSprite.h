//
//  ControllerBaseSprite.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"

#import "FireButtonMenu.h"


@interface Controller : CCSprite {

	FireButton *fireButton;
}

@property (nonatomic, retain) FireButton *fireButton;

+ (id) controllertWithTexture:(CCTexture2D *)aTexture;

@end
