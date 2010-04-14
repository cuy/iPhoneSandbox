//
//  User.h
//  iPhoneSandbox
//
//  Created by Charles Joseph Uy on 4/14/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Player;

@interface User :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Player * currentPlayer;

@end



