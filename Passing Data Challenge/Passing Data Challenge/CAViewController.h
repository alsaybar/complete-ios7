//
//  CAViewController.h
//  Passing Data Challenge
//
//  Created by Christian Alsaybar on 05/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADetailViewController.h"

@interface CAViewController : UIViewController <CADetailViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end
