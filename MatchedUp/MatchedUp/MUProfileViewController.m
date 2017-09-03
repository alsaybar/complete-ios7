//
//  MUProfileViewController.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MUProfileViewController.h"

@interface MUProfileViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLineLabel;

@end

@implementation MUProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  PFFile *pictureFile = self.photo[kMUPhotoPictureKey];
  [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    self.profilePictureImageView.image = [UIImage imageWithData:data];
  }];
  
  PFUser *user = self.photo[kMUPhotoUserKey];
  self.locationLabel.text = user[kMUUserProfileKey][kMUUserProfileLocation];
  self.ageLabel.text = [NSString stringWithFormat:@"%@", user[kMUUserProfileKey][KMUUserProfileAgeKey]];
  
  if (user[kMUUserProfileKey][KMUUSerProfileRelationshipStatusKey] == nil) {
    self.statusLabel.text = @"Single";
  } else self.statusLabel.text = user[kMUUserProfileKey][KMUUSerProfileRelationshipStatusKey];
  
  self.tagLineLabel.text = user[kMUUserTagLineKey];
  
  self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
  self.title = user[kMUUserProfileKey][kMUUserProfileFirstNameKey];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - IBAction

- (IBAction)likeButtonPressed:(UIButton *)sender {
  
  [self.delegate didPressLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender {
  
  [self.delegate didPressDislike];
}


@end
