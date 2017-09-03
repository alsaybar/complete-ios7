//
//  CAHouseView.m
//  Drawing a House
//
//  Created by Christian Alsaybar on 16/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAHouseView.h"

@implementation CAHouseView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  UIBezierPath *house = [UIBezierPath bezierPathWithRect:CGRectMake(self.bounds.origin.x + 10,
                                                                    self.bounds.size.height / 4,
                                                                    self.bounds.size.width - 20,
                                                                    self.bounds.size.height / 3)];
  house.lineWidth = 2.0;
  
  [house stroke];
  
  UIBezierPath *roof = [UIBezierPath bezierPath];
  
  [roof moveToPoint:CGPointMake(self.bounds.origin.x + 30, self.bounds.origin.y + 70)];
  [roof addLineToPoint:CGPointMake(self.bounds.size.width - 30, self.bounds.origin.y + 70)];
  [roof addLineToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height / 4)];
  [roof addLineToPoint:CGPointMake(self.bounds.origin.x + 10, self.bounds.size.height / 4)];
  roof.lineWidth = 2.0;
  [roof closePath];
  [roof stroke];
  
}


@end
