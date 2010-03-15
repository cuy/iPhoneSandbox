//
//  GameMount.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 3/15/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface GameMount :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * armor;
@property (nonatomic, retain) NSNumber * damageFactor;

@end



