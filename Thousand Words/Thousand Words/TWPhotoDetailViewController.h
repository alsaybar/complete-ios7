//
//  TWPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Christian Alsaybar on 17/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface TWPhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)deleteBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
