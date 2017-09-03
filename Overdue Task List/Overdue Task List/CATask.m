//
//  CATask.m
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CATask.h"

@implementation CATask

- (id)init {
  return [self initWithData:nil];
}

-(id)initWithData:(NSDictionary *)data {
  if (self = [super init]) {
    self.title = [data objectForKey:TASK_TITLE];
    self.details = [data objectForKey:TASK_DESCRIPTION];
    self.date = [data objectForKey:TASK_DATE];
    self.completion = [[data objectForKey:TASK_COMPLETION] boolValue];
  }
  
  return self;
}

@end
