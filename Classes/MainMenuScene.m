//
//  MainMenuScene.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "MainMenuScene.h"
#import "GamePlayScene.h"

@implementation MainMenuScene
- (id) init {
    self = [super init];
    if (self != nil) {
       // CCSprite * bg = [Sprite spriteWithFile:@"bg01.png"];
       // [bg setPosition:ccp(240, 160)];
       // [self addChild:bg z:0];
        [self addChild:[MainMenuLayer node] z:1];
    }
    return self;
}
@end

@implementation MainMenuLayer

- (id) init {
    self = [super init];
    if (self != nil) {
        [CCMenuItemFont setFontSize:20];
        [CCMenuItemFont setFontName:@"Helvetica"];
        CCMenuItem *start = [CCMenuItemFont itemFromString:@"Start Game"
												target:self
											  selector:@selector(newGameButtonTapped:)];
       
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
        [menu alignItemsVertically];
        [self addChild:menu];
    }
    return self;
}

- (void)newGameButtonTapped:(id)sender
{
	NSLog(@"newGameButtonTapped");
	[[CCDirector sharedDirector] replaceScene:[GamePlayScene node]];
	
}
@end

