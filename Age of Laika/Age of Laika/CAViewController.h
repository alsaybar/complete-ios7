//
//  CAViewController.h
//  Age of Laika
//
//  Created by Christian Alsaybar on 26/02/14.
//
//

#import <UIKit/UIKit.h>

@interface CAViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *humanYearsTextField;
@property (strong, nonatomic) IBOutlet UILabel *dogYearsLabel;
- (IBAction)convert:(UIButton *)sender;

@end
