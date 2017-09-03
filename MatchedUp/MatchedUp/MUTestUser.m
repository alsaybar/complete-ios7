//
//  MUTestUser.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MUTestUser.h"

@implementation MUTestUser

+(void)saveTestUserToParse {
  
  PFUser *newUser = [PFUser user];
  newUser.username = @"user1";
  newUser.password = @"password1";
  
  [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (!error) {
      NSDictionary *profile = @{@"age": @28, @"birthday" : @"11/22/1985", @"firstName" : @"Julie", @"gender" : @"female", @"location" : @"Berlin, Germany", @"name" : @"Julie Adams"};
      [newUser setObject:profile forKey:@"profile"];
      [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        UIImage *profileImage = [UIImage imageNamed:@"profilepicture.jpg"];
        NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8f);
        PFFile *photoFile = [PFFile fileWithData:imageData];
        [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
          if (succeeded) {
            PFObject *photo = [PFObject objectWithClassName:kMUPhotoClassKey];
            [photo setObject:newUser forKey:kMUPhotoUserKey];
            [photo setObject:photoFile forKey:kMUPhotoPictureKey];
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
              NSLog(@"Photo saved successfully");
            }];
          }
        }];
      }];
    }
  }];
}

@end
