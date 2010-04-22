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
#import "ControllerSprite.h"

#import "FireButtonMenu.h"

#import "MissileSprite.h"

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
		// enable movements for 1st player
		mCurrentPlayer.enabled = YES;

		// set player 2 to be the enemy player
		mEnemyPlayer = [players objectAtIndex:1];
		// hide muzzle for player 2
		mEnemyPlayer.mMuzzle.visible = NO;
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
	aPlayerMount.mMuzzle = [Muzzle spriteWithTexture:muzzleSprite];
	// set muzzle location
	[aPlayerMount setMuzzleLocationForPlayer:(player + 1)];
	// add player muzzle to view
	[self addChild:aPlayerMount.mMuzzle ];
	
	// disable movements in defaults
	aPlayerMount.enabled = NO;
	
	// release the kraken
	[mountTexture release]; mountTexture = nil;
	[muzzleSprite release]; muzzleSprite = nil;
	
	return aPlayerMount;
}

- (void) setupController
{
	// insert controller base
	CCTexture2D *controllerSprite = [[CCTextureCache sharedTextureCache] addImage:@"controller_base.png"];
	controllerBase = [Controller controllertWithTexture:controllerSprite];
	controllerBase.position = ccp(235,73);
	[self addChild:controllerBase z:3];
	
	// insert controller base firebutton
	CCMenuItem *fireButtonItem = [CCMenuItemImage itemFromNormalImage:@"controller_fire_button.png" selectedImage:@"controller_fire_button_up.png" ];
	fireButtonItem.position = ccp(305, 72);
	controllerBase.fireButton = [FireButton menuWithItems:fireButtonItem, nil];
	controllerBase.fireButton.position = CGPointZero;
	//[controllerBase.fireButton setDelegate:self];
	controllerBase.fireButton.delegate = self;
	[self addChild:controllerBase.fireButton z:2];
	
	// initialize power meter
	controllerBase.fireButton.powerMeter = [CCSprite spriteWithFile:@"power_meter.png"];
	[controllerBase.fireButton.powerMeter setAnchorPoint:ccp(0.0f, 0.5f)];
	controllerBase.fireButton.powerMeter.position = ccp(167,61);
	[self addChild:controllerBase.fireButton.powerMeter z:2];
	
	// insert controller base angle label
	angleLabel = [CCLabel labelWithString:@"45" fontName:@"Helvetica" fontSize:10];
	angleLabel.position = ccp(145,59);
	angleLabel.color = ccc3(0, 0, 0);
	[self addChild:angleLabel z:3];
	
	// release the kraken
	[controllerSprite release]; controllerSprite = nil;
}

#pragma mark Game Actions

- (void) changePlayer 
{
	NSLog(@"change player");
	
	// disable movements
	mCurrentPlayer.enabled = NO;
	// hide muzzle
	mCurrentPlayer.mMuzzle.visible = NO;
	
	Mount *swap = mCurrentPlayer;
	mCurrentPlayer = mEnemyPlayer;
	mEnemyPlayer =  swap;
	
	// enable movements for current player
	mCurrentPlayer.enabled = YES;
	// unhide muzzle
	mCurrentPlayer.mMuzzle.visible = YES;
}

- (void) launchMissileWithPower: (float) power
{
	NSLog(@"launcMissile");
	
	CCTexture2D *missileSprite = [[CCTextureCache sharedTextureCache] addImage:@"missile3.png"];
	Missile *missile = [Missile missileWithTexture:missileSprite];
	missile.position = mCurrentPlayer.mMuzzle.position;
	missile.angle = mCurrentPlayer.mMuzzle.angle;
	missile.velocity = power;
	[self addChild:missile z:0];
	
	[missile launchMissile];
	
	// release the kraken
	[missileSprite release]; missileSprite = nil;
	//[self removeChild:missile cleanup:NO];
	//[missile release]; missile = nil;
	
}

- (void) setPower: (float) power
{
	mCurrentPlayer.mMuzzle.power = power;
}


#pragma mark Button Actions

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
	//NSLog(@"current angle : %f",currentAngle);

	if (currentAngle <= 80.0f && currentAngle >= -45.0f && mCurrentPlayer == [players objectAtIndex:0]) {
		mCurrentPlayer.mMuzzle.rotation = -currentAngle;
	}
	else if ((currentAngle >= 100.0f || currentAngle <= -135.0f) && mCurrentPlayer == [players objectAtIndex:1]) {
		mCurrentPlayer.mMuzzle.rotation = 180 - currentAngle;
	}
	
	// rotate muzzle
	mGestureStartPoint = currentPosition;
	// set angle label
	[angleLabel setString:[NSString stringWithFormat:@"%.0f", mCurrentPlayer.mMuzzle.rotation]];
	
	// set angle to currentplayer muzzle
	mCurrentPlayer.mMuzzle.angle = -currentAngle;
	//NSLog(@"mCurrentPlayer.mMuzzle.rotation : %f",currentAngle);
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	//NSLog(@"touchended");
}

- (void) dealloc
{
	[super dealloc];
	//[[CCDirector sharedDirector] release];
	[[CCTextureCache sharedTextureCache] removeAllTextures];
	[players release];
}

@end
