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
#import "MuzzleSprite.h"
#import "ControllerBaseSprite.h"

@implementation GamePlayScene


- (id)init {
	
	if ((self = [super init])) {
		[self addChild:[GamePlayLayer node] z:1];
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

@end

@implementation GamePlayLayer

@synthesize mPlayer1, mPlayer2, mCurrentPlayer;

- (id) init {
    self = [super init];
    if (self != nil) {
        isTouchEnabled = YES;
		
		// set background image
		CCSprite *bg = [CCSprite spriteWithFile:@"gameBG.png"];
		bg.position = ccp(bg.contentSize.width/2,bg.contentSize.height/2);
		[self addChild:bg z:0];
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		//player 1
		CCTexture2D *mountTexture = [[CCTextureCache sharedTextureCache] addImage:@"player1.png"];
		mPlayer1 = [Mount mountWithTexture:mountTexture];
		mPlayer1.position = ccp(50, winSize.height/2);
		[self addChild:mPlayer1 z:1];	
		// add player 1 muzzle
		CCTexture2D *muzzleSprite = [[CCTextureCache sharedTextureCache] addImage:@"muzzle.png"];
		mPlayer1.mMuzzle = [CCSprite spriteWithTexture:muzzleSprite];
		mPlayer1.mMuzzle.position = ccp(mPlayer1.position.x+30,mPlayer1.position.y - 9);
		[self addChild:mPlayer1.mMuzzle ];
		
		//player 2
		mPlayer2 = [Mount mountWithTexture:mountTexture];
		mPlayer2.position = ccp(430, winSize.height/2);
		mPlayer2.scaleX = -mPlayer2.scaleX;
		[self addChild:mPlayer2];
		
		// set current player
		mCurrentPlayer = mPlayer1;
		
		// insert controllerbase firebutton
		CCMenuItem *fireButtonMenuItem = [CCMenuItemImage itemFromNormalImage:@"controller_fire_button.png" selectedImage:@"controller_fire_button_up.png" target:self selector:@selector(fireButtonTapped:)];
		fireButtonMenuItem.position = ccp(305,72);
		CCMenu *fireButtonMenu = [CCMenu menuWithItems:fireButtonMenuItem, nil];
		fireButtonMenu.position = CGPointZero;
		[self addChild:fireButtonMenu];
		
		// insert controllerbase sprite
		ControllerBase *controllerBase = [ControllerBase alloc];
		controllerBase = [controllerBase initWithImage:@"controller_base.png"];
		[self addChild:controllerBase];
		
		// insert controllerbase angle label
		angleLabel = [CCLabel labelWithString:@"45" fontName:@"Helvetica" fontSize:10];
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

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchces began");
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:[touch view]];
	mGestureStartPoint = [[CCDirector sharedDirector] convertToGL:mGestureStartPoint];
	//return YES;

}
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touched moved");
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:[touch view]];
	currentPosition = [[CCDirector sharedDirector] convertToGL:currentPosition];
	
	// Arc Tangent Formula
	CGFloat currentAngle = atan2(mGestureStartPoint.y - mCurrentPlayer.mMuzzle.position.y,mGestureStartPoint.x - mCurrentPlayer.mMuzzle.position.x)*180.0/M_PI;
	
	if(currentAngle < -90.0){
		currentAngle = -90.0;
	}
	else if(currentAngle > 45.0){
		currentAngle = 45.0;
	}
	
	mCurrentPlayer.mMuzzle.rotation = currentAngle;
	mGestureStartPoint = currentPosition;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touchended");
}
@end

