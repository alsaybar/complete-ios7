//
//  CADetailViewController.h
//  Passing Data Challenge
//
//  Created by Christian Alsaybar on 05/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CADetailViewControllerDelegate <NSObject>

@required
-(void)didUpdateText:(NSString *)text;

@end
@interface CADetailViewController : UIViewController

@property (weak, nonatomic) id <CADetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) NSString *labelText;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)updateButtonPressed:(id)sender;

@end
