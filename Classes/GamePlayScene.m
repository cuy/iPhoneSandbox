//
//  GamePlayScene.m
//  GunBoundcocos2d
//
//  Created by Royce Albert Dy on 3/16/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GamePlayScene.h"
#import "MainMenuScene.h"
#import "MountSprite.h"
//#import "ControllerBaseSprite.h"

@implementation GamePlayScene

- (id) init {
    self = [super init];
    if (self != nil) {
        CCSprite *bg = [CCSprite spriteWithFile:@"gameBG.png"];
        [bg setPosition:ccp(bg.contentSize.width/2, bg.contentSize.height/2)];
        [self addChild:bg z:0];
        [self addChild:[GamePlayLayer node] z:1];
		NSLog(@"gameplayscene init");
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
	
		//player 1
		CCTexture2D *mountTexture = [[CCTextureCache sharedTextureCache] addImage:@"player1.png"];
		mPlayer1 = [Mount mountWithTexture:mountTexture];
		mPlayer1.position = ccp(50, winSize.height/2);
		[self addChild:mPlayer1];	
		
		//player 2
		mPlayer2 = [Mount mountWithTexture:mountTexture];
		mPlayer2.position = ccp(430, winSize.height/2);
		mPlayer2.scaleX = -mPlayer2.scaleX;
		[self addChild:mPlayer2];
		
		// insert controllerbase firebutton
		CCMenuItem *fireButtonMenuItem = [CCMenuItemImage itemFromNormalImage:@"controller_fire_button.png" selectedImage:@"controller_fire_button_up.png" target:self selector:@selector(fireButtonTapped:)];
		fireButtonMenuItem.position = ccp(305,72);
		CCMenu *fireButtonMenu = [CCMenu menuWithItems:fireButtonMenuItem, nil];
		fireButtonMenu.position = CGPointZero;
		[self addChild:fireButtonMenu];
		
		// insert controllerbase sprite
		CCSprite *controllerBase = [CCSprite spriteWithFile:@"controller_base.png" rect:CGRectMake(0, 0, 237, 99)];
		controllerBase.position = ccp(235,73);
		[self addChild:controllerBase];
		
		// insert controllerbase angle label
		CCLabel* angleLabel = [CCLabel labelWithString:@"45" fontName:@"Helvetica" fontSize:10];
		angleLabel.position = ccp(145,59);
		angleLabel.color = ccc3(0, 0, 0);
		[self addChild:angleLabel];

		
    }
    return self;
}

- (void) fireButtonTapped: (id) sender
{
	NSLog(@"fireButtonTapped");
}

- (void) dealloc
{
	[super dealloc];
	[mPlayer1 release];
	[mPlayer2 release];
}

@end

@implementation GamePlayLayer

- (id) init {
    self = [super init];
    if (self != nil) {
        isTouchEnabled = YES;
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchces began");
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
	NSLog(@"touch position x: %f y: %f",location.x,location.y);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchended");
}
@end

