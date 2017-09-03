//
//  CAEditTaskViewController.m
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAEditTaskViewController.h"

@interface CAEditTaskViewController ()

@end

@implementation CAEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setu;p after loading the view.
  self.taskTitleTextField.delegate = self;
  self.taskDetailsTextView.delegate = self;
  
  self.taskTitleTextField.text = self.task.title;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  [self.taskDatePicker setDate:self.task.date];
  
  self.taskDetailsTextView.text = self.task.details;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
#warning if a task is updated, it disappears, but reappears when application is reloaded
  [self updateTask];
  [self.delegate didEditTask];
  [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)updateTask {
  if ([self.taskTitleTextField.text isEqualToString:@""]) self.task.title = self.title = @"Untitled";
  else self.task.title = self.taskTitleTextField.text;
  self.task.details = self.taskDetailsTextView.text;
  self.task.date = self.taskDatePicker.date;
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - UITextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  if([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  }
  
  return YES;
}
@end
