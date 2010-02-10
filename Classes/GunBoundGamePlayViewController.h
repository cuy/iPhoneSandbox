//
//  GunBoundGamePlayViewController.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Mount;

@interface GunBoundGamePlayViewController : UIViewController {
	
	// Avatar Variables
	Mount *mountOneView;
	
	NSTimer *timer;
	
	// Player Variables
	CGPoint playerOnePos;
}

@property(nonatomic, readonly, assign) Mount *mountOneView;

@property(retain, nonatomic) NSTimer *timer;

- (IBAction)upButton:(id)sender;
- (IBAction)downButton:(id)sender;
- (IBAction)stopTimerButton:(id)sender;
- (IBAction)fireButton:(id)sender;
- (IBAction)exitGame:(id)sender;

@end
