//
//  OWSpaceDataViewController.h
//  Out Of This World
//
//  Created by Christian Alsaybar on 05/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;

@end
