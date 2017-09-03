//
//  CAViewController.m
//  NSUserDefaults, Segues and Protocols
//
//  Created by Christian Alsaybar on 08/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"
#import "CACreateAccountViewController.h"

@interface CAViewController ()

@end

@implementation CAViewController

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
  
  self.usernameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
  self.passwordLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PASSWORD];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
