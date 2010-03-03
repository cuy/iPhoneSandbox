//
//  Mount.h
//  iPhoneSandbox
//
//  Created by Royce Albert Dy on 3/2/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Mount : NSObject {
	
	UIColor *bgColor;
	int player;
	CGPoint position;	
	CGFloat angle;
	
}

@property CGPoint position;
@property CGFloat angle;
@property (nonatomic,retain) UIColor *bgColor;
@property int player;

@end
