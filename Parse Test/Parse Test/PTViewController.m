//
//  PTViewController.m
//  Parse Test
//
//  Created by Christian Alsaybar on 18/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation PTViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)saveUserButtonPressed:(UIButton *)sender {
  
  PFObject *loginCredentials = [PFObject objectWithClassName:@"LoginCredentials"];
  loginCredentials[@"name"] = self.usernameTextField.text;
  loginCredentials[@"password"] = self.passwordTextField.text;
  
  [loginCredentials saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save" message:@"Your object was saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
    } else if (error) {
      NSLog(@"%@", error);
    }
  }];
}
@end
