//
//  MUEditProfileViewController.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MUEditProfileViewController.h"

@interface MUEditProfileViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tagLineTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MUEditProfileViewController

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
  
  PFQuery *query = [PFQuery queryWithClassName:kMUPhotoClassKey];
  [query whereKey:kMUPhotoUserKey equalTo:[PFUser currentUser]];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if ([objects count] > 0) {
      PFObject *photo = objects[0];
      PFFile *pictureFile = photo[kMUPhotoPictureKey];
      [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
      }];
    }
  }];
  self.tagLineTextView.text = [[PFUser currentUser] objectForKey:kMUUserTagLineKey];
  
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

#pragma mark - UITextView Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
  
  CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
  [self.scrollView setContentOffset:bottomOffset animated:YES];
}

#pragma mark - IBActions

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender {
  
  [[PFUser currentUser] setObject:self.tagLineTextView.text forKey:kMUUserTagLineKey];
  [[PFUser currentUser] saveInBackground];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
