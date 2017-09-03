//
//  CACreateAccountViewController.m
//  NSUserDefaults, Segues and Protocols
//
//  Created by Christian Alsaybar on 08/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CACreateAccountViewController.h"

@interface CACreateAccountViewController ()

@end

@implementation CACreateAccountViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {

  [self.delegate didCancel];
}

- (IBAction)createAccountButtonPressed:(UIButton *)sender {
  if ([self.usernameTextField.text length] && [self.passwordTextField.text length] && [self.confirmPasswordTextField.text length]) {
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
      [[NSUserDefaults standardUserDefaults] setObject:self.usernameTextField.text forKey:USER_NAME];
      [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:USER_PASSWORD];
      [[NSUserDefaults standardUserDefaults] synchronize];
      
      [self.delegate didCreateAccount];
    } else {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password must mach" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
    }
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
  }
}

@end
