//
//  CATask.h
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CATask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

-(id)initWithData:(NSDictionary *)data;

@end
