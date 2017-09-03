//
//  CADetailTaskViewController.m
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CADetailTaskViewController.h"
#import "CAViewController.h"

@interface CADetailTaskViewController ()

@end

@implementation CADetailTaskViewController

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
  self.taskTitleLabel.text = self.task.title;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  self.taskDateLabel.text = [dateFormatter stringFromDate:self.task.date];
  
  self.taskDetailsTextView.text = self.task.details;
  self.completionImageView.image = self.taskCompletionImage;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"editTaskViewControllerSegue"]) {
    CAEditTaskViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.task = self.task;
    destinationViewController.delegate = self;
  }
}

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
  [self performSegueWithIdentifier:@"editTaskViewControllerSegue" sender:sender];
}

#pragma mark - CAEditTaskViewController Delegate

-(void)didEditTask {
  [self viewDidLoad];
  [self.delegate updateTask];
}
@end
