//
//  CASignInViewController.m
//  NSUserDefaults, Segues and Protocols
//
//  Created by Christian Alsaybar on 08/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CASignInViewController.h"
#import "CAViewController.h"

@interface CASignInViewController ()

@end

@implementation CASignInViewController

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"toCreateAccountViewControllerSegue"]) {
    CACreateAccountViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.delegate = self;
  }
}

- (IBAction)createAccountBarButtonItemPressed:(UIButton *)sender {
  [self performSegueWithIdentifier:@"toCreateAccountViewControllerSegue" sender:sender];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
  
  if ([[[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME] isEqualToString:self.userNameTextField.text] && [[[NSUserDefaults standardUserDefaults] stringForKey:USER_PASSWORD] isEqualToString:self.passwordTextField.text]) {
    [self performSegueWithIdentifier:@"toViewControllerSegue" sender:nil];
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No account exists for input" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
  }
}

#pragma mark - CACreateAccountViewController Delegate

-(void)didCancel {
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCreateAccount {
  
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
