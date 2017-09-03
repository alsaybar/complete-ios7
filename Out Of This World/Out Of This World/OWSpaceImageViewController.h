//
//  OWSpaceImageViewController.h
//  Out Of This World
//
//  Created by Christian Alsaybar on 05/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;

@end
