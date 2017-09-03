//
//  CADetailTaskViewController.h
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAEditTaskViewController.h"

@protocol CADetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface CADetailTaskViewController : UIViewController <CAEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <CADetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) CATask *task;
@property (strong, nonatomic) UIImage *taskCompletionImage;

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIImageView *completionImageView;

- (IBAction)editBarButtonPressed:(id)sender;

@end
