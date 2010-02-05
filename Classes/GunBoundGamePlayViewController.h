//
//  GunBoundGamePlayViewController.h
//  iPhoneSandbox
//
//  Created by Royce Dy on 2/3/10.
//  Copyright 2010 G2iX. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GunBoundGamePlayViewController : UIViewController {
	
	IBOutlet UIImageView *playerOneAvatar;
	NSTimer *timer;
	
	// Player Variables
	CGPoint playerOnePos;
}

@property(retain, nonatomic) IBOutlet UIImageView *playerOneAvatar;
@property(retain, nonatomic) NSTimer *timer;
//@property(retain, nonatomic) CGPoint *playerOnePos;

- (IBAction)upButton:(id)sender;
- (IBAction)downButton:(id)sender;
- (IBAction)stopTimerButton:(id)sender;
- (IBAction)fireButton:(id)sender;
- (IBAction)exitGame:(id)sender;

@end
