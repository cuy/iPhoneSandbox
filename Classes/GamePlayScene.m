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

@synthesize mCurrentPlayer, mEnemyPlayer;

- (id) init {
    self = [super init];
    if (self != nil) {
        isTouchEnabled = YES;
		
		// game initializers
		[self setupBackground]; // initialize background
		players = [[NSMutableArray alloc] init]; // initialize players array
		[self setupPlayers:2]; // initialize number of players
		[self setupController]; // initialize controller
		
		// set player 1 to be the first to move
		mCurrentPlayer = [players objectAtIndex:0];
		// set player 2 to be the enemy player
		mEnemyPlayer = [players objectAtIndex:1];
    }
    return self;
}

#pragma mark Game methods and initializers

- (void) setupBackground
{
	// set background image
	CCSprite *bg = [CCSprite spriteWithFile:@"gameBG.png"];
	bg.position = ccp(bg.contentSize.width/2,bg.contentSize.height/2);
	[self addChild:bg z:0];	
}

- (void) setupPlayers:(int)total {
    for (NSUInteger i = 0; i < total; ++i) {
        [players addObject:[self setupPlayer:i]];
    }
}

- (Mount *)setupPlayer:(int)player {
	
	// add player image
	CCTexture2D *mountTexture = [[CCTextureCache sharedTextureCache] addImage:@"player.png"];
	// initialize with player image
	Mount *aPlayerMount = [Mount mountWithTexture:mountTexture];
	// set random location for player
	[aPlayerMount setRandomLocationForPlayer:(player + 1)];
	// add player to view
	[self addChild:aPlayerMount z:1];	
	
	// add muzzle image
	CCTexture2D *muzzleSprite = [[CCTextureCache sharedTextureCache] addImage:@"muzzle.png"];
	// initialize player muzzle with muzzle image
	aPlayerMount.mMuzzle = [CCSprite spriteWithTexture:muzzleSprite];
	// set muzzle location
	[aPlayerMount setMuzzleLocationForPlayer:(player + 1)];
	// add player muzzle to view
	[self addChild:aPlayerMount.mMuzzle ];
	
	[mountTexture release];
	[muzzleSprite release];
	
	return aPlayerMount;
}

- (void) setupController
{
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

#pragma mark Game Actions

- (void) changePlayer 
{
	Mount *swap = mCurrentPlayer;
	mCurrentPlayer = mEnemyPlayer;
	mEnemyPlayer =  swap;
}

#pragma mark Button Actions

- (void) fireButtonTapped: (id) sender
{
	NSLog(@"fireButtonTapped");
	[self changePlayer];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchces began");
	UITouch *touch = [touches anyObject];
	mGestureStartPoint = [touch locationInView:[touch view]];
	mGestureStartPoint = [[CCDirector sharedDirector] convertToGL:mGestureStartPoint];
	//return YES;

}
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touched moved");
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:[touch view]];
	currentPosition = [[CCDirector sharedDirector] convertToGL:currentPosition];
	
	// Arc Tangent Formula
	CGFloat currentAngle = atan2(mGestureStartPoint.y - mCurrentPlayer.mMuzzle.position.y,mGestureStartPoint.x - mCurrentPlayer.mMuzzle.position.x)*180.0/M_PI;
	NSLog(@"current angle : %f",currentAngle);

	if (currentAngle <= 80.0f && currentAngle >= -45.0f && mCurrentPlayer == [players objectAtIndex:0]) {
		mCurrentPlayer.mMuzzle.rotation = -currentAngle;
	}
	else if ((currentAngle >= 100.0f || currentAngle <= -135.0f) && mCurrentPlayer == [players objectAtIndex:1]) {
		mCurrentPlayer.mMuzzle.rotation = 180 - currentAngle;
	}
	
	// rotate muzzle
	
	mGestureStartPoint = currentPosition;
	NSLog(@"mCurrentPlayer.mMuzzle.rotation : %f",mCurrentPlayer.mMuzzle.rotation);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchended");
}

- (void) dealloc
{
	[super dealloc];
	[[CCTextureCache sharedTextureCache] removeAllTextures];
	[players release];
}

@end
