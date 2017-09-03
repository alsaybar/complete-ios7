//
//  CAAddTaskViewController.m
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAAddTaskViewController.h"

@interface CAAddTaskViewController ()

@end

@implementation CAAddTaskViewController

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
  // Do any additional setup after loading the view.
  self.taskTitleTextField.delegate = self;
  self.taskDetailsTextView.delegate = self;
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
  [self.delegate didAddTask:[self newTask]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
  [self.delegate didCancel];
}

-(CATask *)newTask {
  
  CATask *newTask = [[CATask alloc] init];
  if ([self.taskTitleTextField.text isEqualToString:@""]) newTask.title = self.title = @"Untitled";
  else newTask.title = self.taskTitleTextField.text;
  newTask.details = self.taskDetailsTextView.text;
  newTask.date = self.taskDatePicker.date;
  newTask.completion = NO;
  
  return newTask;
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  [textField resignFirstResponder];
  return NO;
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
