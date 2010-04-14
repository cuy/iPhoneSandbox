//
//  Player.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 4/14/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Game;
@class GameMount;
@class Projectile;
@class User;

@interface Player :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) Game * partOf;
@property (nonatomic, retain) NSSet* weapons;
@property (nonatomic, retain) User * userInfo;
@property (nonatomic, retain) GameMount * mount;

@end


@interface Player (CoreDataGeneratedAccessors)
- (void)addWeaponsObject:(Projectile *)value;
- (void)removeWeaponsObject:(Projectile *)value;
- (void)addWeapons:(NSSet *)value;
- (void)removeWeapons:(NSSet *)value;

@end

