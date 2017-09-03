//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Christian Alsaybar on 16/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext {
  
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  
  if ([delegate performSelector:@selector(managedObjectContext)]) context = [delegate managedObjectContext];

  
  return context;
}

@end
