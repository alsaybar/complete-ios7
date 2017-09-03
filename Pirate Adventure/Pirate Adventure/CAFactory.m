//
//  CATileFactory.m
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 28/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAFactory.h"
#import "CATile.h"


@implementation CAFactory

+(NSArray *)tiles {
  
  CAWeapon *sword = [[CAWeapon alloc] init];
  sword.name = @"Blunted Sword";
  sword.damage = 10;
  
  CAWeapon *pistol = [[CAWeapon alloc] init];
  pistol.name = @"Pistol";
  pistol.damage = 15;
  
  CAArmor *steelArmor = [[CAArmor alloc] init];
  steelArmor.name = @"Steel Armor";
  steelArmor.health = 20;
  
  CAArmor *parrot = [[CAArmor alloc] init];
  parrot.name = @"Parrot";
  parrot.health = 40;
  
  NSArray *images = [[NSArray alloc] initWithObjects:
                     [UIImage imageNamed:@"PirateStart.jpg"],
                     [UIImage imageNamed:@"PirateWeapons.jpeg"],
                     [UIImage imageNamed:@"PirateTreasure.jpeg"],
                     [UIImage imageNamed:@"PirateFriendlyDock.jpg"],
                     [UIImage imageNamed:@"PiratePlank.jpg"],
                     [UIImage imageNamed:@"PirateShipBattle.jpeg"],
                     [UIImage imageNamed:@"PirateTreasurer2.jpeg"],
                     [UIImage imageNamed:@"PirateBlacksmith.jpeg"],
                     [UIImage imageNamed:@"PirateAttack.jpg"],
                     [UIImage imageNamed:@"PirateBoss.jpeg"],
                     [UIImage imageNamed:@"PirateParrot.jpg"],
                     [UIImage imageNamed:@"PirateOctopusAttack.jpg"],
                     nil];
  
  int healthEffects[12] = {0, 0, 10, 12, -23, -15, -10, 0, -10, -10, 0, -50};
  
  NSArray *actionButtonTitles = [[NSArray alloc] initWithObjects:
                                 @"Take sword",
                                 @"Wield pistol",
                                 @"Open treasure",
                                 @"Stop at dock",
                                 @"Show no fear",
                                 @"To arms!",
                                 @"Go deeper",
                                 @"Use steel armor",
                                 @"Repel the scum",
                                 @"Fight!",
                                 @"Adopt parrot",
                                 @"Release The Kraken!",
                                 nil];
  
  NSArray *stories = [[NSArray alloc] initWithObjects:
                      @"Captain, we need a fearless leader like you to undertake a voyage! You must stop the evil Pirate Boss so take this Blunted Sword.",
                      @"You have stumbled upon a cache of pirate weapons. Would you like to upgrade to a pistol?",
                      @"You have stumbled upon a hidden cave with a pirate treasure",
                      @"A mysterious dock appears on the horizon. Should we stop and ask for directions?",
                      @"You have been captured by pirates and are ordered to walk the plank!",
                      @"You have sighted a pirate battle off the coast. Should we intervene?",
                      @"In the deep of the sea, many things live and many things can be found. Will the fortune bring help or ruin?",
                      @"You have come across an armory. Would you like to upgrade your armor to steel armor?",
                      @"A group of pirates attempts to board your ship!",
                      @"Your final faceoff with the fearsome pirate boss!",
                      @"You have found a parrot. This can be used in your armor slot. Parrots are great defenders and are fiercly loyal to their captain!",
                      @"The legend of the deep. The mighty Kraken appears",
                      nil];
  
  NSArray *weapons = [[NSArray alloc] initWithObjects:
                      sword,
                      pistol,
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      nil];
  
  NSArray *armors = [[NSArray alloc] initWithObjects:
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      [NSNull null],
                      steelArmor,
                      [NSNull null],
                      [NSNull null],
                      parrot,
                      [NSNull null],
                      nil];
   
  NSMutableArray *columnOne = [[NSMutableArray alloc] init];
  NSMutableArray *columnTwo = [[NSMutableArray alloc] init];
  NSMutableArray *columnThree = [[NSMutableArray alloc] init];
  NSMutableArray *columnFour = [[NSMutableArray alloc] init];
  
  for (int i = 1; i <= 12; i++) {
    CATile *tile = [[CATile alloc] init];
    tile.story = [stories objectAtIndex:i - 1];
    tile.backgroundImage = [images objectAtIndex:i - 1];
    tile.weapon = [weapons objectAtIndex:i - 1];
    tile.armor = [armors objectAtIndex:i - 1];
    tile.healthEffect = healthEffects[i - 1];
    tile.actionButtonTitle = [actionButtonTitles objectAtIndex:i - 1];
    
    if (i <= 3) {
      [columnOne addObject:tile];
    }
    if (i > 3 && i <= 6) {
      [columnTwo addObject:tile];
    }
    if (i > 6 && i <= 9) {
      [columnThree addObject:tile];
    }
    if (i > 9 && i <= 12) {
      [columnFour addObject:tile];
    }
  }
  
  NSArray *tileMap = [[NSArray alloc] initWithObjects:columnOne, columnTwo, columnThree, columnFour, nil];
  return tileMap;
}
+(CACharacter *)character {
  
  CACharacter *character = [[CACharacter alloc] init];
  CAWeapon *weapon = [[CAWeapon alloc] init];
  CAArmor *armor = [[CAArmor alloc] init];
  
  weapon.name = @"Fists";
  weapon.damage = 10;
  
  armor.name = @"Old Garments";
  armor.health = 5;
  
  character.weapon = weapon;
  character.armor = armor;
  character.health = 100;
  
  return character;
}
+(CABoss *)boss {
  CABoss *boss = [[CABoss alloc] init];
  boss.health = 130;
  
  return boss;
}

@end
