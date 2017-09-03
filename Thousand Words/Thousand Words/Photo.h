//
//  Photo.h
//  Thousand Words
//
//  Created by Christian Alsaybar on 16/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Album *albumBook;

@end
