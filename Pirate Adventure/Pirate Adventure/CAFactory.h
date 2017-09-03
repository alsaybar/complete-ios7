//
//  CATileFactory.h
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 28/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CACharacter.h"
#import "CABoss.h"

@interface CAFactory : NSObject

@property (strong, nonatomic) NSArray *tiles;

+(NSArray *)tiles;
+(CACharacter *)character;
+(CABoss *)boss;

@end
