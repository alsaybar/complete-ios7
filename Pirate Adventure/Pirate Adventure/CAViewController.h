//
//  CAViewController.h
//  Pirate Adventure
//
//  Created by Christian Alsaybar on 28/02/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CACharacter.h"
#import "CABoss.h"

@interface CAViewController : UIViewController

@property (strong, nonatomic) NSArray *tiles;
@property (nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) CACharacter *character;
@property (strong, nonatomic) CABoss *boss;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *healthLabel;
@property (strong, nonatomic) IBOutlet UILabel *damageLabel;
@property (strong, nonatomic) IBOutlet UILabel *weaponLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorLabel;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UILabel *storyLabel;
@property (strong, nonatomic) IBOutlet UIButton *north;
@property (strong, nonatomic) IBOutlet UIButton *east;
@property (strong, nonatomic) IBOutlet UIButton *south;
@property (strong, nonatomic) IBOutlet UIButton *west;

- (IBAction)northPressed:(id)sender;
- (IBAction)eastPressed:(id)sender;
- (IBAction)southPressed:(id)sender;
- (IBAction)westPressed:(id)sender;
- (IBAction)actionPressed:(id)sender;
- (IBAction)newGamePressed:(id)sender;

@end
