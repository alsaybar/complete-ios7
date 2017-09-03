//
//  CASignInViewController.h
//  NSUserDefaults, Segues and Protocols
//
//  Created by Christian Alsaybar on 08/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CACreateAccountViewController.h"

@interface CASignInViewController : UIViewController <CACreateAccountViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)createAccountBarButtonItemPressed:(UIButton *)sender;
- (IBAction)loginButtonPressed:(UIButton *)sender;

@end
