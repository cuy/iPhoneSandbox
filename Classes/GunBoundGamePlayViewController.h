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
}

@property(retain, nonatomic) IBOutlet UIImageView *playerOneAvatar;
@property(retain, nonatomic) NSTimer *timer;

- (IBAction)upButton:(id)sender;
- (IBAction)downButton:(id)sender;
- (IBAction)stopTimerButton:(id)sender;

@end
