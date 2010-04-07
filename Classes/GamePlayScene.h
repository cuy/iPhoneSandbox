//
//  GamePlayScene.h
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "cocos2d.h"
#import "MountSprite.h"
#import "ControllerSprite.h"


@interface GamePlayLayer : CCLayer {
	
	Mount *mCurrentPlayer, *mEnemyPlayer;
	NSMutableArray *players;
	
	CCLabel *angleLabel; 
	
	// touch vars
	CGPoint mGestureStartPoint;
	
	Controller *controllerBase;	
}

@property (nonatomic,retain) Mount *mCurrentPlayer, *mEnemyPlayer;

// game methods and initializers
- (void) setupBackground;
- (Mount *)setupPlayer:(int)player;
- (void) setupPlayers:(int)total;
- (void) setupController;
@end

@interface GamePlayScene : CCScene {
	
}


@end