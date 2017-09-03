//
//  MUMatchViewController.h
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MUMatchViewControllerDelegate <NSObject>

-(void)presentMatchesViewController;

@end

@interface MUMatchViewController : UIViewController

@property (weak, nonatomic) id <MUMatchViewControllerDelegate> delegate;

@property (strong, nonatomic) UIImage *matchedUserImage;

@end
