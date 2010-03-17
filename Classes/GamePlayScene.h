//
//  GamePlayScene.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"
#import "MountSprite.h"


@interface GamePlayLayer : CCLayer {
	
	Mount *mPlayer1, *mPlayer2, *mCurrentPlayer;
	
	CCLabel *angleLabel; 
	
	// touch vars
	CGPoint mGestureStartPoint;

}
@property (nonatomic,retain) Mount *mPlayer1, *mPlayer2, *mCurrentPlayer;

@end

@interface GamePlayScene : CCScene {
	
}


@end