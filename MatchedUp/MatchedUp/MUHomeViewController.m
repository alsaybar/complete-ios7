//
//  MUHomeViewController.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MUHomeViewController.h"
#import "MUProfileViewController.h"
#import "MUMatchViewController.h"
#import "MUTransitionAnimator.h"
#import "MUTestUser.h"

@interface MUHomeViewController () <MUMatchViewControllerDelegate, MUProfileViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *chatBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsBarButtonItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *dislikeButton;
@property (strong, nonatomic) IBOutlet UIView *labelContainerView;
@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;

@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) PFObject *photo;
@property (strong, nonatomic) NSMutableArray *activities;

@property (nonatomic) int currentPhotoIndex;
@property (nonatomic) BOOL isLikedByCurrentUser;
@property (nonatomic) BOOL isDislikedByCurrentUser;

@end

@implementation MUHomeViewController

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
  
  //  [MUTestUser saveTestUserToParse];
  
  [self setupViews];
  
}

-(void)viewDidAppear:(BOOL)animated {
  
  self.photoImageView.image = nil;
  self.firstNameLabel.text = nil;
  self.ageLabel.text = nil;
  
  self.likeButton.enabled = NO;
  self.dislikeButton.enabled = NO;
  self.infoButton.enabled = NO;
  
  self.currentPhotoIndex = 0;
  
  PFQuery *query = [PFQuery queryWithClassName:kMUPhotoClassKey];
  [query whereKey:kMUPhotoUserKey notEqualTo:[PFUser currentUser]];
  [query includeKey:kMUPhotoUserKey]; // Makes the user associated with the photo available to us
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
      self.photos = objects;
      if ([self allowPhoto] == NO) [self setupNextPhoto];
      else [self queryForCurrentPhotoIndex];
    } else {
      NSLog(@"%@", error);
    }
  }];
  [self checkForActivity];
}

-(void)setupViews {
  
  [self addShadowForView:self.buttonContainerView];
  [self addShadowForView:self.labelContainerView];
  self.photoImageView.layer.masksToBounds = YES;
  self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}

-(void)addShadowForView:(UIView *)view {
  
  view.layer.masksToBounds = NO;
  view.layer.cornerRadius = 4;
  view.layer.shadowRadius = 1;
  view.layer.shadowOffset = CGSizeMake(0, 1);
  view.layer.shadowOpacity = 0.25;
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"homeToProfileSegue"]) {
    MUProfileViewController *profileVC = segue.destinationViewController;
    profileVC.photo = self.photo;
    profileVC.delegate = self;
  }
}

#pragma mark - IBActions

- (IBAction)chatBarButtonItemPressed:(UIBarButtonItem *)sender {
  
  [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
}

- (IBAction)settingsBarButtonItem:(UIBarButtonItem *)sender {
}

- (IBAction)likeButtonPressed:(UIButton *)sender {
  
  Mixpanel *mixpanel = [Mixpanel sharedInstance];
  
  [mixpanel track:@"Like"];
  [mixpanel flush];
  
  [self checkLike];
}

- (IBAction)dislikeButtonPressed:(UIButton *)sender {
  
  Mixpanel *mixpanel = [Mixpanel sharedInstance];
  
  [mixpanel track:@"Dislike"];
  [mixpanel flush];
  
  [self checkDisLike];
}

- (IBAction)infoButtonPressed:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
}

#pragma mark - Helper Methods

-(void)queryForCurrentPhotoIndex {
  
  if ([self.photos count] > 0) {
    self.photo = self.photos[self.currentPhotoIndex];
    PFFile *file = self.photo[kMUPhotoPictureKey];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
      if (!error) {
        UIImage *image = [UIImage imageWithData:data];
        self.photoImageView.image = image;
        [self updateView];
      } else NSLog(@"%@", error);
    }];
    
    PFQuery *queryForLike = [PFQuery queryWithClassName:kMUActivityClassKey];
    [queryForLike whereKey:kMUActivityTypeKey equalTo:kMUActivityTypeLikeKey];
    [queryForLike whereKey:kMUActivityPhotoKey equalTo:self.photo];
    [queryForLike whereKey:kMUActivityFromUserKey equalTo:[PFUser currentUser]];
    
    PFQuery *queryForDislike = [PFQuery queryWithClassName:kMUActivityClassKey];
    [queryForDislike whereKey:kMUActivityTypeKey equalTo:kMUActivityTypeDislikeKey];
    [queryForDislike whereKey:kMUActivityPhotoKey equalTo:self.photo];
    [queryForDislike whereKey:kMUActivityFromUserKey equalTo:[PFUser currentUser]];
    
    PFQuery *likeAndDislikeQuery = [PFQuery orQueryWithSubqueries:@[queryForLike, queryForDislike]];
    [likeAndDislikeQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {
        self.activities = [objects mutableCopy];
        if ([self.activities count] == 0) {
          self.isLikedByCurrentUser = NO;
          self.isDislikedByCurrentUser = NO;
        } else {
          PFObject *activity = self.activities[0];
          
          if ([activity[kMUActivityTypeKey] isEqualToString:kMUActivityTypeLikeKey]) {
            self.isLikedByCurrentUser = YES;
            self.isDislikedByCurrentUser = NO;
          } else if ([activity[kMUActivityTypeKey] isEqualToString:kMUActivityTypeDislikeKey]) {
            self.isLikedByCurrentUser = NO;
            self.isDislikedByCurrentUser = YES;
          } else {
            //Some other activity ...
          }
        }
        self.likeButton.enabled = YES;
        self.dislikeButton.enabled = YES;
        self.infoButton.enabled = YES;
      }
    }];
  }
}

-(void)updateView {
  
  self.firstNameLabel.text = self.photo[kMUPhotoUserKey][kMUUserProfileKey][kMUUserProfileFirstNameKey];
  self.ageLabel.text = [NSString stringWithFormat:@"%@", self.photo[kMUPhotoUserKey][kMUUserProfileKey][KMUUserProfileAgeKey]];
}

-(void)setupNextPhoto {
  
  if (self.currentPhotoIndex + 1 < self.photos.count) {
    self.currentPhotoIndex++;
    if ([self allowPhoto] == NO) {
      [self setupNextPhoto];
    } else {
      [self queryForCurrentPhotoIndex];
    }
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No More Users To View" message:@"Check back later for more people!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
  }
}

-(BOOL)allowPhoto {
  
  int maxAge = [[NSUserDefaults standardUserDefaults] integerForKey:kMUAgeMaxKey];
  BOOL men = [[NSUserDefaults standardUserDefaults] boolForKey:kMUMenEnabledKey];
  BOOL women = [[NSUserDefaults standardUserDefaults] boolForKey:kMUWomenEnabledKey];
  BOOL single = [[NSUserDefaults standardUserDefaults] boolForKey:kMUSingleEnabledKey];
  
  PFObject *photo = self.photos[self.currentPhotoIndex];
  PFUser *user = photo[kMUPhotoUserKey];
  
  int userAge = [user[kMUUserProfileKey][KMUUserProfileAgeKey] intValue];
  NSString *gender = user[kMUUserProfileKey][kMUUserProfileGender];
  NSString *relationshipStatus = user[kMUUserProfileKey][KMUUSerProfileRelationshipStatusKey];
  
  if (userAge > maxAge) {
    return NO;
  } else if (men == NO && [gender isEqualToString:@"male"]) {
    return NO;
  } else if (women == NO && [gender isEqualToString:@"female"]) {
    return NO;
  } else if (single == NO && ([relationshipStatus isEqualToString:@"single"])) {
    return NO;
  } else {
    return YES;
  }
}

-(void)saveLike {
  
  PFObject *likeActivity = [PFObject objectWithClassName:kMUActivityClassKey];
  [likeActivity setObject:kMUActivityTypeLikeKey forKey:kMUActivityTypeKey];
  [likeActivity setObject:[PFUser currentUser] forKey:kMUActivityFromUserKey];
  [likeActivity setObject:[self.photo objectForKey:kMUPhotoUserKey] forKey:kMUActivityToUserKey];
  [likeActivity setObject:self.photo forKey:kMUActivityPhotoKey];
  [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    self.isLikedByCurrentUser = YES;
    self.isDislikedByCurrentUser = NO;
    [self.activities addObject:likeActivity];
    [self checkForPhotoUserLikes];
    [self setupNextPhoto];
  }];
}

-(void)saveDislike {
  
  PFObject *dislikeActivity = [PFObject objectWithClassName:kMUActivityClassKey];
  [dislikeActivity setObject:kMUActivityTypeDislikeKey forKey:kMUActivityTypeKey];
  [dislikeActivity setObject:[PFUser currentUser] forKey:kMUActivityFromUserKey];
  [dislikeActivity setObject:[self.photo objectForKey:kMUPhotoUserKey] forKey:kMUActivityToUserKey];
  [dislikeActivity setObject:self.photo forKey:kMUActivityPhotoKey];
  [dislikeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    self.isLikedByCurrentUser = NO;
    self.isDislikedByCurrentUser = YES;
    [self.activities addObject:dislikeActivity];
    [self setupNextPhoto];
  }];
}

-(void)checkLike {
  
  if (self.isLikedByCurrentUser) {
    [self setupNextPhoto];
    return;
  } else if (self.isDislikedByCurrentUser) {
    for (PFObject *activity in self.activities) {
      [activity deleteInBackground];
    }
    [self.activities removeLastObject];
    [self saveLike];
  } else {
    [self saveLike];
  }
}

-(void)checkDisLike {
  
  if (self.isDislikedByCurrentUser) {
    [self setupNextPhoto];
    return;
  } else if (self.isLikedByCurrentUser) {
    for (PFObject *activity in self.activities) {
      [activity deleteInBackground]; // Deletes from Parse DB
    }
    [self.activities removeLastObject]; // Deletes from local array
    [self saveDislike];
  } else {
    [self saveDislike];
  }
}

-(void)checkForPhotoUserLikes {
  
  // select query from class Activity
  PFQuery *query = [PFQuery queryWithClassName:kMUActivityClassKey];
  // select rows where fromUser is same the same as the user owning the current photo
  [query whereKey:kMUActivityFromUserKey equalTo:self.photo[kMUPhotoUserKey]];
  // select rows where toUser is the same as the current user (of the app)
  [query whereKey:kMUActivityToUserKey equalTo:[PFUser currentUser]];
  // select rows where there's a like only
  [query whereKey:kMUActivityTypeKey equalTo:kMUActivityTypeLikeKey];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if ([objects count] > 0) {
      [self createChatRoom];
    }
  }];
}

-(BOOL)checkForActivity {
  
  __block BOOL didLikeOrDislike;
  
  // select query from class Activity
  PFQuery *query = [PFQuery queryWithClassName:kMUActivityClassKey];
  // select rows where fromUser is same the same as the user owning the current photo
  [query whereKey:kMUActivityFromUserKey equalTo:[PFUser currentUser]];
  // select rows where toUser is the same as the current user (of the app)
  [query whereKey:kMUActivityToUserKey equalTo:self.photo[kMUPhotoUserKey]];
  // select rows where there's a like only
  [query whereKey:kMUActivityTypeKey equalTo:kMUActivityTypeLikeKey];
  [query whereKey:kMUActivityTypeKey equalTo:kMUActivityTypeDislikeKey];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if ([objects count] > 0) {
      if (objects[0] == kMUActivityTypeLikeKey) {
        NSLog(@"%@", objects[0]);
        didLikeOrDislike = YES;
      }
    }
  }];
  
  return didLikeOrDislike;
}

-(void)createChatRoom {
  
  PFQuery *queryForChatRoom = [PFQuery queryWithClassName:kMUChatRoomClassKey];
  [queryForChatRoom whereKey:kMUChatRoomUser1Key equalTo:[PFUser currentUser]];
  [queryForChatRoom whereKey:kMUChatRoomUser2Key equalTo:self.photo[kMUPhotoUserKey]];
  
  PFQuery *queryForChatRoomInverse = [PFQuery queryWithClassName:kMUChatRoomClassKey];
  [queryForChatRoomInverse whereKey:kMUChatRoomUser1Key equalTo:self.photo[kMUPhotoUserKey]];
  [queryForChatRoomInverse whereKey:kMUChatRoomUser2Key equalTo:[PFUser currentUser]];
  
  PFQuery *combinedQuery = [PFQuery orQueryWithSubqueries:@[queryForChatRoom, queryForChatRoomInverse]];
  [combinedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if ([objects count] == 0) {
      PFObject *chatRoom  = [PFObject objectWithClassName:kMUChatRoomClassKey];
      [chatRoom setObject:[PFUser currentUser] forKey:kMUChatRoomUser1Key];
      [chatRoom setObject:self.photo[kMUPhotoUserKey] forKey:kMUChatRoomUser2Key];
      [chatRoom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        UIStoryboard *myStoryboard = self.storyboard;
        MUMatchViewController *matchViewController = [myStoryboard instantiateViewControllerWithIdentifier:@"matchVC"];
        matchViewController.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.75];
        matchViewController.transitioningDelegate = self;
        matchViewController.matchedUserImage = self.photoImageView.image;
        matchViewController.delegate = self;
        matchViewController.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:matchViewController animated:YES completion:nil];
        
      }];
    }
  }];
}

#pragma mark - MUMatchViewController Delegate

-(void)presentMatchesViewController {
  
  [self dismissViewControllerAnimated:YES completion:^{
    [self performSegueWithIdentifier:@"homeToMatchesSegue" sender:nil];
  }];
}

#pragma mark - MUProfileViewController Delegate

-(void)didPressLike {
  
  [self.navigationController popViewControllerAnimated:NO];
  [self checkLike];
}

-(void)didPressDislike {
  
  [self.navigationController popViewControllerAnimated:NO];
  [self checkDisLike];
}

#pragma mark - UIViewControllerTransitioning Delegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  
  MUTransitionAnimator *animator = [[MUTransitionAnimator alloc] init];
  animator.presenting = YES;
  
  return animator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  
  MUTransitionAnimator *animator = [[MUTransitionAnimator alloc] init];
  return animator;
}

@end
