//
//  CAViewController.m
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 28/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"
#import "CAFactory.h"
#import "CATile.h"

@interface CAViewController ()

@end

@implementation CAViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.tiles = [CAFactory tiles];
  self.character = [CAFactory character];
  self.boss = [CAFactory boss];
  self.currentPoint = CGPointMake(0, 0);
  [self updateCharacterWithArmor:nil weapon:nil healthEffect:0];
  [self updateTile];

}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)northPressed:(id)sender {
  self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y + 1);
  [self updateTile];
}

- (IBAction)eastPressed:(id)sender {
  self.currentPoint = CGPointMake(self.currentPoint.x + 1, self.currentPoint.y);
  [self updateTile];
}

- (IBAction)southPressed:(id)sender {
  self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y - 1);
  [self updateTile];
}

- (IBAction)westPressed:(id)sender {
  self.currentPoint = CGPointMake(self.currentPoint.x - 1, self.currentPoint.y);
  [self updateTile];
}

- (IBAction)actionPressed:(id)sender {
  CATile *currentTile = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
  
  [self updateCharacterWithArmor:currentTile.armor weapon:currentTile.weapon healthEffect:currentTile.healthEffect];
  if (currentTile.backgroundImage == [UIImage imageNamed:@"PirateBoss.jpeg"]) {
    self.boss.health = self.boss.health - self.character.damage;
    NSLog(@"%i", self.boss.health);
  }
  [self updateTile];
  //[sender setEnabled:NO];
  
  if (self.character.health < 0) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Defeat" message:@"You failed your quest!" delegate:nil cancelButtonTitle:@"Arr!" otherButtonTitles:nil, nil];
    [alert show];
  } else if (self.boss.health < 0) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victory" message:@"You beat the evil pirate!" delegate:nil cancelButtonTitle:@"Blimey!" otherButtonTitles:nil, nil];
    [alert show];
  }
}

- (IBAction)newGamePressed:(id)sender {
  self.character = nil;
  self.boss = nil;
  [self viewDidLoad];
}

- (void)updateCharacterWithArmor:(CAArmor *)armor weapon:(CAWeapon *)weapon healthEffect:(int)healthEffect {
  if (![armor isKindOfClass:[NSNull class]] && armor != nil) {
    self.character.armor = armor;
    self.character.health = self.character.health - self.character.armor.health + armor.health;
  } else if (![weapon isKindOfClass:[NSNull class]] && weapon != nil) {
    self.character.weapon = weapon;
    self.character.damage = self.character.damage - self.character.damage + weapon.damage;
  } else if (healthEffect != 0) {
    self.character.health = self.character.health + healthEffect;
  } else  {
    self.character.health = self.character.health + self.character.armor.health;
    self.character.damage = self.character.damage + self.character.weapon.damage;
  }
}

- (void)updateTile {
  CATile *currentTile = [[self.tiles objectAtIndex:self.currentPoint.x]objectAtIndex:self.currentPoint.y];
  self.storyLabel.text = currentTile.story;
  self.backgroundImageView = [self.backgroundImageView initWithImage:currentTile.backgroundImage];
  self.healthLabel.text = [NSString stringWithFormat:@"%i", self.character.health + self.character.armor.health];
  self.damageLabel.text = [NSString stringWithFormat:@"%i", self.character.damage + self.character.weapon.damage];
  self.weaponLabel.text = self.character.weapon.name;
  self.armorLabel.text = self.character.armor.name;
  [self.actionButton setTitle:currentTile.actionButtonTitle forState:UIControlStateNormal];
  
  [self.actionButton setEnabled:YES];
  [self updateButtons];
}

- (void)updateButtons {
  self.west.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x - 1, self.currentPoint.y)];
  self.north.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y + 1)];
  self.east.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x + 1, self.currentPoint.y)];
  self.south.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y - 1)];
}

- (BOOL)tileExistsAtPoint:(CGPoint)point {
  return !(point.x >= 0 && point.y >= 0 && point.x < [self.tiles count] && point.y < [[self.tiles objectAtIndex:point.x] count]);
}
@end
