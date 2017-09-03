//
//  CAViewController.m
//  Passing Data Challenge
//
//  Created by Christian Alsaybar on 05/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"

@interface CAViewController ()

@end

@implementation CAViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //if ([sender isKindOfClass:[UIButton class]]) {
    if ([segue.destinationViewController isKindOfClass:[CADetailViewController class]]) {
      NSString *textField = self.textField.text;
      CADetailViewController *nextViewController = segue.destinationViewController;
      nextViewController.labelText = textField;
      nextViewController.delegate = self;
    }
  //}
}

-(void)didUpdateText:(NSString *)text {
  self.textField.text = text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self performSegueWithIdentifier:@"pushToDetailView" sender:nil];
  [self.textField resignFirstResponder];
  return YES;
}

@end
