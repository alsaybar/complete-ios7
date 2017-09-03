//
//  CAViewController.m
//  A View Into the World
//
//  Created by Christian Alsaybar on 12/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"

@interface CAViewController ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation CAViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  
  self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 22)];
  self.label.text = @"I'm a label";
  self.label.backgroundColor = [UIColor grayColor];
  [self.view addSubview:self.label];
  
  self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 280, 30)];
  self.textField.placeholder = @"Placeholder";
  self.textField.backgroundColor = [UIColor redColor];
  [self.view addSubview:self.textField];
  
  UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  myButton.frame = CGRectMake(20, 160, 280, 30);
  [myButton setTitle:@"press me!" forState:UIControlStateNormal];
  [myButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:myButton];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)buttonPressed:(UIButton *)sender {
  self.label.text = self.textField.text;
  [self.textField resignFirstResponder];

}

@end
