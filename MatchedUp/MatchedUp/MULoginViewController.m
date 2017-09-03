//
//  MULoginViewController.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 18/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MULoginViewController.h"

@interface MULoginViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableData *imageData;

@end

@implementation MULoginViewController

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
  self.activityIndicator.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated {
  
  if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
    [self updateUserInformation];
    [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
  }
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

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(UIButton *)sender {
  
  self.activityIndicator.hidden = NO;
  [self.activityIndicator startAnimating];
  
  NSArray *permissionsArray = @[@"user_about_me", @"user_interests", @"user_relationships", @"user_birthday", @"user_location", @"user_relationship_details"];
  
  [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
    if (!user) {
      [self.activityIndicator stopAnimating];
      self.activityIndicator.hidden = YES;
      if (!error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Failed to log in with Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
      } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
      }
    } else {
      [self updateUserInformation];
      [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
    }
  }];
}

#pragma mark - Helper Methods

-(void)updateUserInformation {
  
  FBRequest *request = [FBRequest requestForMe];
  
  [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if (!error) {
      NSDictionary *userDictionary = (NSDictionary *) result;
      
      //Create URL for profile picture
      NSString *facebookID = userDictionary[@"id"];
      NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
      
      NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
      
      if (userDictionary[@"name"]) userProfile[kMUUserProfileNameKey] = userDictionary[@"name"];
      if (userDictionary[@"first_name"]) userProfile[kMUUserProfileFirstNameKey] = userDictionary[@"first_name"];
      if (userDictionary[@"location"][@"name"]) userProfile[kMUUserProfileLocation] = userDictionary[@"location"][@"name"];
      if (userDictionary[@"gender"]) userProfile[kMUUserProfileGender] = userDictionary[@"gender"];
      
      if (userDictionary[@"birthday"]) userProfile[kMUUserProfileBirthday] = userDictionary[@"birthday"];
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateStyle:NSDateFormatterShortStyle];
      NSDate *date = [dateFormatter dateFromString:userDictionary[@"birthday"]];
      NSDate *now = [NSDate date];
      NSTimeInterval seconds = [now timeIntervalSinceDate:date];
      int age = seconds / 31536000;
      userProfile[KMUUserProfileAgeKey] = @(age);
      
      if (userDictionary[@"interested_in"]) userProfile[kMUUserProfileInterestedIn] = userDictionary[@"interested_in"];
      if (userDictionary[@"relationship_status"]) userProfile[KMUUSerProfileRelationshipStatusKey] = userDictionary[@"relationship_status"];
      if ([pictureURL absoluteString]) userProfile[kMUUserProfilePictureURL] = [pictureURL absoluteString];
      
      [[PFUser currentUser] setObject:userProfile forKey:kMUUserProfileKey];
      [[PFUser currentUser] saveInBackground];
      
      [self requestImage];
    } else {
      NSLog(@"Error in Facebook request %@", error);
    }
  }];
}

-(void)uploadPFFileToParse:(UIImage *)image {
  
  NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
  
  if (!imageData) {
    NSLog(@"Image data not found");
    return;
  }
  
  PFFile *photoFile = [PFFile fileWithData:imageData];
  
  [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
      // Sets the properties for the row in the Photo class
      PFObject *photo = [PFObject objectWithClassName:kMUPhotoClassKey];
      [photo setObject:[PFUser currentUser] forKey:kMUPhotoUserKey];
      [photo setObject:photoFile forKey:kMUPhotoPictureKey];
      [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Photo saved succesfully");
      }];
    }
  }];
  
}

-(void)requestImage {
  
  PFQuery *query = [PFQuery queryWithClassName:kMUPhotoClassKey];
  // Constraints the query so the only photo returned is the on stored of the current user
  [query whereKey:kMUPhotoUserKey equalTo:[PFUser currentUser]];
  
  [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
    if (number == 0) {
      PFUser *user = [PFUser currentUser];
      self.imageData = [[NSMutableData alloc] init];
      
      // Retrieves the picture URL from the profile row
      NSURL *profilePictureURL = [NSURL URLWithString:user[kMUUserProfileKey][kMUUserProfilePictureURL]];
      NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
      NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
      if (!urlConnection) {
        NSLog(@"Failed to download picture");
      }
    }
  }];
}

#pragma mark - NSURLConnectionData Delegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  [self.imageData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  UIImage *profileImage = [UIImage imageWithData:self.imageData];
  [self uploadPFFileToParse:profileImage];
}








@end
