//
//  CAViewController.m
//  Age of Laika
//
//  Created by Christian Alsaybar on 26/02/14.
//
//

#import "CAViewController.h"

@interface CAViewController ()

@end

@implementation CAViewController

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

- (IBAction)convert:(UIButton *)sender {
  int humanYears = [self.humanYearsTextField.text floatValue];
  self.dogYearsLabel.text = [NSString stringWithFormat:@"%i", humanYears * 7];
  [self resignFirstResponder];
}
@end
