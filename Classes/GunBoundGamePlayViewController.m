//
//  GunBoundGamePlayViewController.m
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import "GunBoundGamePlayViewController.h"
#import "MuzzleView.h"
#import "Mount.h"
#import "MountView.h"
#import "MissileView.h"
#import "Missile.h"
#import "Game.h"
#import "Player.h"
#import "NormalGameMount.h"
#import "GameMissile.h"


#define degreesToRadian(x) (M_PI * x / 180.0)

#define TOTAL_GAME_MISSILE 2


@implementation GunBoundGamePlayViewController

@synthesize managedObjectContext;
@synthesize managedObjectModel;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        players = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark Buttons

- (IBAction)stopTimerButton:(id)sender {
	if (mTimer != nil) 
		[mTimer invalidate];
	mTimer = nil;
}

- (IBAction) fireButton:(id)sender {
    // check if more missles are available
    NSEntityDescription *projectileEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Projectile"];
    NSString *orderKey = @"player.order";
    NSNumber *orderValue = [NSNumber numberWithInt:currentPlayer];
    NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:@"%K == %@", orderKey, orderValue];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:projectileEntity];
    [fetchRequest setPredicate:fetchPredicate];
    
    NSError *error = nil;
    NSArray *projectiles = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if ((error != nil) || (projectiles == nil)) {
        NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
    
    
    NSLog(@"projectiles = %d", [projectiles count]);
    if([projectiles count] > 0)
    {
        [[self managedObjectContext] deleteObject:[projectiles objectAtIndex:0]];
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(addPower:) userInfo:nil repeats:YES];
    }
    else {
        // for now, just add more ammo so ammo becomes infinite
        NSLog(@"out of ammo");
        [self refillAmmo];
        error = nil;
        projectiles = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        if ((error != nil) || (projectiles == nil)) {
            NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
        NSLog(@"projectiles = %d", [projectiles count]);        
        [[self managedObjectContext] deleteObject:[projectiles objectAtIndex:0]];
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(addPower:) userInfo:nil repeats:YES];
    }
    
    [fetchRequest release];
}

- (void)refillAmmo {
    NSEntityDescription *playerDescription = [[[self managedObjectModel] entitiesByName] objectForKey:@"Player"];
    NSString *playerKey = @"order";
    NSNumber *playerValue = [NSNumber numberWithInt:currentPlayer];
    NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:@"%K == %@", playerKey, playerValue];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:playerDescription];
    [fetchRequest setPredicate:fetchPredicate];
    
    NSError *error = nil;
    NSArray *playersFetched = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if ((error != nil) || (playersFetched == nil)) {
        NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
    
    NSLog(@"found = %d", [playersFetched count]);
    NSAssert([playersFetched count] == 1, @"Wrong number of players found");
    Player *aPlayer = [playersFetched objectAtIndex:0];
    
    NSEntityDescription *gameMissile = [[[self managedObjectModel] entitiesByName] objectForKey:@"GameMissile"];
    for(int i = 0; i < TOTAL_GAME_MISSILE; ++i)
    {
        GameMissile *aGameMissile = [[GameMissile alloc] initWithEntity:gameMissile insertIntoManagedObjectContext:[self managedObjectContext]];
        [aPlayer addWeaponsObject:aGameMissile];
        [aGameMissile release];
    }    
    
    [fetchRequest release];
}

- (IBAction)fireMissile:(id)sender {
	[self stopTimerButton:sender];
	
	mMissileView = [[MissileView alloc] initWithFrame:CGRectMake(mMountView.mMuzzleView.center.x, mMountView.mMuzzleView.center.y, 31, 14)];
	mMissileView.mMissile.velocity = mPower;
	mMissileView.mMissile.cx = mMountView.mMuzzleView.center.x;
	mMissileView.mMissile.cy = mMountView.mMuzzleView.center.y;
	mMissileView.mMissile.angle = mMountView.mMount.angle;
	[self.view insertSubview:mMissileView belowSubview:mMountView];
	[mMissileView fireMissileFrom:mMountView toEnemyMountView:mEnemyMountView];
	[mMissileView setDelegate:self];
	[mMissileView release];
    
	// re-init mpower
	mPower = 0;
    [self setPowerBarValue:mPower];
    
	//disable power button
	[powerButton setEnabled:NO];
}

- (IBAction)exitGame:(id)sender {
	
}

- (void)setPowerBarValue:(int)value {
    CGFloat mScalex = value;
	CGAffineTransform trans = CGAffineTransformMakeScale(mScalex/145*1, 1.0);
	powerBar.transform = trans;    
}

#pragma mark avatar movements

- (void)addPower:(id)sender
{
	// Check if the power is greater than the MAX POWER which is 145
	if(mPower >= 145) {
		//set the power to the max power
		mPower = 145;
	}
	// otherwise increment the power by 5
	else {
		mPower += 5;
	}
    
    [self setPowerBarValue:mPower];
}

- (void)setupPowerGauge {
	//set powerGauge default scale and orientation;
	CGAffineTransform defaultScale = CGAffineTransformMakeScale(0.01, 1.0);
	CGPoint defaultCenter = powerBar.center;
	defaultCenter.x -= 50.0;
	[powerBar.layer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
	powerBar.center = defaultCenter;
	powerBar.transform = defaultScale;
}

- (void)setupBackground {
	// set background image
	UIColor *bgImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"gameBG.png"]];
	self.view.backgroundColor = bgImage;
	[bgImage release];    
}

- (MountView *)setupPlayer:(int)player {
    MountView *aPlayerMount = [[MountView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) forPlayer:(player + 1)];
    [self.view addSubview:aPlayerMount];
    [aPlayerMount setRandomLocation];
    
    NSDictionary *playersInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PlayerConfigurations" ofType:@"plist"]];
    NSDictionary *currentPlayerInfo = [playersInfo objectForKey:[NSString stringWithFormat:@"player%.2d", player]];
    NSLog(@"player = %d\n%@", player, currentPlayerInfo);
    aPlayerMount.mMount.angle = [[currentPlayerInfo objectForKey:@"mountAngle"] floatValue];
    aPlayerMount.mMuzzleView.initialAngle = [[currentPlayerInfo objectForKey:@"muzzleInitialAngle"] floatValue];
    CGFloat xOffset = [[currentPlayerInfo objectForKey:@"muzzleXOffset"] floatValue];
    CGFloat yOffset = [[currentPlayerInfo objectForKey:@"muzzleYOffset"] floatValue];
    aPlayerMount.offsets = CGPointMake(xOffset, yOffset);
    
    NSEntityDescription *playerEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Player"];
    Player *aPlayer = [[Player alloc] initWithEntity:playerEntity insertIntoManagedObjectContext:[self managedObjectContext]];
    [aPlayer setOrder:[NSNumber numberWithInt:player]];
    
    NSEntityDescription *mountEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"NormalGameMount"];
    NormalGameMount *aNormalGameMount = [[NormalGameMount alloc] initWithEntity:mountEntity insertIntoManagedObjectContext:[self managedObjectContext]];
    [aPlayer setMount:aNormalGameMount];
    [aNormalGameMount release];
    
    NSEntityDescription *gameMissile = [[[self managedObjectModel] entitiesByName] objectForKey:@"GameMissile"];
    for(int i = 0; i < TOTAL_GAME_MISSILE; ++i)
    {
        GameMissile *aGameMissile = [[GameMissile alloc] initWithEntity:gameMissile insertIntoManagedObjectContext:[self managedObjectContext]];
        [aPlayer addWeaponsObject:aGameMissile];
        [aGameMissile release];
    }
    
    [game addPlayersObject:aPlayer];
    [aPlayer release];
    return [aPlayerMount autorelease];
}

- (void)setupPlayers:(int)total {
    for (NSUInteger i = 0; i < total; ++i) {
        [players addObject:[self setupPlayer:i]];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSEntityDescription *gameEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"Game"];
    game = [[Game alloc] initWithEntity:gameEntity insertIntoManagedObjectContext:[self managedObjectContext]];
	
	//set the power button to enabled
	[powerButton setEnabled:YES];
    [self setupPowerGauge];
    [self setupBackground];
    [self setupPlayers:2];
	
	// set player 1 to be the first to move
	mMountView = [players objectAtIndex:0];
	// set player 2 to be the enemy
	mEnemyMountView = [players objectAtIndex:1];
    
    currentPlayer = 0;
	
	// set powerlabel
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
}

- (void)missileProjectileCompleted:(BOOL)didHitEnemy {
	// hide current player muzzle
	mMountView.mMuzzleView.hidden = YES;
    
    MountView *swap = mMountView;
    mMountView = mEnemyMountView;
    mEnemyMountView = swap;
	
	// unhide new player muzzle
	mMountView.mMuzzleView.hidden = NO;
    
    currentPlayer = currentPlayer == 0 ? 1 : 0;
	
	angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
	
	//enable power button
	[powerButton setEnabled:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if([btnFire isEnabled]) {
        UITouch *touch = [touches anyObject];
        mGestureStartPoint = [touch locationInView:self.view];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// Activate touch move if the FIRE BUTTON is enabled :D
	if ([powerButton isEnabled]) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPosition = [touch locationInView:self.view];
        
        // Arc Tangent Formula
        CGFloat currentAngle = atan2(mGestureStartPoint.y - mMountView.mMuzzleView.center.y,mGestureStartPoint.x - mMountView.mMuzzleView.center.x)*180.0/M_PI;
        
        NSDictionary *playersInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PlayerConfigurations" ofType:@"plist"]];
        NSDictionary *currentPlayerInfo = [playersInfo objectForKey:[NSString stringWithFormat:@"player%.2d", (mMountView.mMount.player - 1)]];
        
        if (currentAngle >= 0) {
            CGFloat max = [[currentPlayerInfo objectForKey:@"posAngleMax"] floatValue];
            CGFloat min = [[currentPlayerInfo objectForKey:@"posAngleMin"] floatValue];
            CGFloat def = [[currentPlayerInfo objectForKey:@"posAngleDefault"] floatValue];
            
            if (currentAngle > max || currentAngle < min) {
                currentAngle = def;
            }
        }
        else {
            CGFloat max = [[currentPlayerInfo objectForKey:@"negAngleMax"] floatValue];
            CGFloat min = [[currentPlayerInfo objectForKey:@"negAngleMin"] floatValue];
            CGFloat def = [[currentPlayerInfo objectForKey:@"negAngleDefault"] floatValue];            
            
            if (currentAngle < max || currentAngle > min) {
                currentAngle = def;
            }
        }
        
        [mMountView.mMuzzleView rotateAngle:currentAngle];
        mMountView.mMount.angle = currentAngle * -1;
        mGestureStartPoint = currentPosition;
        
        // set powerlabel
        angleLabel.text = [NSString stringWithFormat:@"%.0f",mMountView.mMount.angle];
	}
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	//return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
    [players release];
	[mMissileView release];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"deleting Game");
    [[self managedObjectContext] deleteObject:game];
    
}

@end
