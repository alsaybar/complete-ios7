//
//  OWAddSpaceObjectViewController.m
//  Out Of This World
//
//  Created by Christian Alsaybar on 08/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

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
  UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
  self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
  [self.delegate didCancel];
}

- (IBAction)addButtonPressed:(UIButton *)sender {
  [self.delegate addSpaceObject:[self returnNewSpaceObject]];
}

-(OWSpaceObject *)returnNewSpaceObject {
  OWSpaceObject *newSpaceObject = [[OWSpaceObject alloc] init];
  newSpaceObject.name = self.nameTextField.text;
  newSpaceObject.nickname = self.nicknameTextField.text;
  newSpaceObject.diameter = [self.diameterTextField.text floatValue];
  newSpaceObject.temperature = [self.temperatureTextField.text floatValue];
  newSpaceObject.numberOfMoons = [self.moonsTextField.text intValue];
  newSpaceObject.interestingFact = self.factTextField.text;
  newSpaceObject.spaceImage = [UIImage imageNamed:@"EinsteinRing.jpg"];
  
  return newSpaceObject;
}
@end
