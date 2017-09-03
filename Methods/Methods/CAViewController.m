//
//  CAViewController.m
//  Methods
//
//  Created by Christian Alsaybar on 26/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"

@interface CAViewController ()

@end

@implementation CAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSLog(@"%i", [self factorialOfNumber:0]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) printNumbersToOne:(int) from {
  for (int i = from; i >= 1; i--) {
    NSLog(@"%i", i);
  }
}

-(void) printNumbersFrom:(int)from to:(int)to {
  int largest;
  int smallest;
  
  if (from > to) {
    largest = from;
    smallest = to;
  } else {
    largest = to;
    smallest = from;
  }
  
  for (int i = largest; i >= smallest; i--) {
    NSLog(@"%i", i);
  }
}

-(int) factorialOfNumber:(int)number {
  int factorial = 1;
  for (int i = number; i >= 1; i--) {
    factorial = factorial * i;
  }
  return factorial;
}


@end
