//
//  Projectile.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 4/14/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Player;

@interface Projectile :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * damage;
@property (nonatomic, retain) Player * player;

@end



