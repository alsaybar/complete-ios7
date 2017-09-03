//
//  CAViewController.h
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAAddTaskViewController.h"
#import "CADetailTaskViewController.h"
#import "CAEditTaskViewController.h"

@interface CAViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CAAddTaskViewControllerDelegate, CADetailTaskViewControllerDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *savedTasks;

@property (strong, nonatomic) NSMutableArray *overdueTasks;
@property (strong, nonatomic) NSMutableArray *pendingTasks;
@property (strong, nonatomic) NSMutableArray *completedTasks;


- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;
@end
