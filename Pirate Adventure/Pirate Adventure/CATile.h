//
//  CATile.h
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 28/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAWeapon.h"
#import "CAArmor.h"

@interface CATile : NSObject

@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) NSString *actionButtonTitle;
@property (strong, nonatomic) CAWeapon *weapon;
@property (strong, nonatomic) CAArmor *armor;
@property (nonatomic) int healthEffect;

@end
