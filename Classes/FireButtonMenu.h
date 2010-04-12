//
//  FireButton.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 4/12/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol FireButtonMenuDelegate

- (void) changePlayer;

@end


@interface FireButton : CCMenu {

	float power;
	CCSprite *powerMeter;
	
	id <FireButtonMenuDelegate> delegate;
	
}

@property (nonatomic, assign) <FireButtonMenuDelegate> delegate;
@property (nonatomic, retain) CCSprite *powerMeter;


-(CCMenuItem *) itemForTouch: (UITouch *) touch;

@end
