//
//  MUProfileViewController.h
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MUProfileViewControllerDelegate <NSObject>

-(void)didPressLike;
-(void)didPressDislike;

@end

@interface MUProfileViewController : UIViewController

@property (weak, nonatomic) id <MUProfileViewControllerDelegate> delegate;

@property (strong, nonatomic) PFObject *photo;

@end
