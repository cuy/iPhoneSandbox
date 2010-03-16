//
//  Player.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 3/16/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class GameMount;
@class Projectile;
@class User;

@interface Player :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) Projectile * weapons;
@property (nonatomic, retain) User * userInfo;
@property (nonatomic, retain) GameMount * mount;

@end



