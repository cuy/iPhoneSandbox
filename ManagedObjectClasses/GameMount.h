//
//  GameMount.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 4/14/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Player;

@interface GameMount :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * armor;
@property (nonatomic, retain) NSNumber * damageFactor;
@property (nonatomic, retain) Player * player;

@end



