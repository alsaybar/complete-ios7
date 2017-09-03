//
//  CACharacter.h
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 01/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAWeapon.h"
#import "CAArmor.h"

@interface CACharacter : NSObject

@property (strong, nonatomic) CAWeapon* weapon;
@property (strong, nonatomic) CAArmor* armor;
@property (nonatomic) int health;
@property (nonatomic) int damage;

@end
