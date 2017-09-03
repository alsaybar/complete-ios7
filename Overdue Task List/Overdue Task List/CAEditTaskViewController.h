//
//  CAEditTaskViewController.h
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CAEditTaskViewControllerDelegate <NSObject>

-(void)didEditTask;

@end

@interface CAEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <CAEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) CATask *task;

@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
