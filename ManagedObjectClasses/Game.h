//
//  Game.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 4/14/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Player;

@interface Game :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* players;

@end


@interface Game (CoreDataGeneratedAccessors)
- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)value;
- (void)removePlayers:(NSSet *)value;

@end

