//
//  CAViewController.m
//  Overdue Task List
//
//  Created by Christian Alsaybar on 09/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "CAViewController.h"

@interface CAViewController ()

@end

@implementation CAViewController

#pragma mark - Lazy instantiation

-(NSMutableArray *)savedTasks {
  if (!_savedTasks) {
    _savedTasks = [[NSMutableArray alloc] init];
  }
  return _savedTasks;
}

-(NSMutableArray *)overdueTasks {
  if (!_overdueTasks) {
    _overdueTasks = [[NSMutableArray alloc] init];
  }
  return _overdueTasks;
}

-(NSMutableArray *)pendingTasks {
  if (!_pendingTasks) {
    _pendingTasks = [[NSMutableArray alloc] init];
  }
  return _pendingTasks;
}

-(NSMutableArray *)completedTasks {
  if (!_completedTasks) {
    _completedTasks = [[NSMutableArray alloc] init];
  }
  return _completedTasks;
}

#pragma mark - ViewDidLoad

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.tableView.delegate = self;
  
  [self loadSavedTasks];
  
  [self reloadDataSource];
  
  //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVED_TASKS];
  //  [[NSUserDefaults standardUserDefaults] synchronize];
  NSLog(@"Overdue tasks %lu", (unsigned long)[self.overdueTasks count]);
  NSLog(@"Pending tasks %lu", (unsigned long)[self.pendingTasks count]);
  NSLog(@"Completed tasks %lu", (unsigned long)[self.completedTasks count]);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"addTaskViewControllerSegue"]) {
    CAAddTaskViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.delegate = self;
  }
  
  if ([segue.identifier isEqualToString:@"detailTaskViewControllerSegue"]) {
    CADetailTaskViewController *destinationViewController = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    CATask *task;
    if (indexPath.section == 0) task = self.overdueTasks[indexPath.row];
    if (indexPath.section == 1) task = self.pendingTasks[indexPath.row];
    if (indexPath.section == 2) task = self.completedTasks[indexPath.row];
    destinationViewController.task = task;
    destinationViewController.taskCompletionImage = [self completionImageForTask:task AtDate:task.date];
    destinationViewController.delegate = self;
  }
}

#pragma mark - UITableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 0) return @"Overdue Tasks";
  else if (section == 1) return @"Pending Tasks";
  return @"Completed Tasks";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  if (section == 0) return [self.overdueTasks count];
  if (section == 1) return [self.pendingTasks count];
  return [self.completedTasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  CATask *task = [self selectedTaskForSectionAtIndexPath:indexPath];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  
  cell.textLabel.text = task.title;
  cell.detailTextLabel.text = [dateFormatter stringFromDate:task.date];
  cell.imageView.image = [self completionImageForTask:task AtDate:task.date];
  
  return cell;
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  // Present an alertview when changing a tasks completion state
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"detailTaskViewControllerSegue" sender:indexPath];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"row %ld section %ld", (long)indexPath.row, (long)indexPath.section);
  CATask *selectedTask = [self selectedTaskForSectionAtIndexPath:indexPath];
  
  
  //  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete Task?" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
  //  [alert show];
  selectedTask.completion = !selectedTask.completion;
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self updateTask];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 70.0;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
#warning crashes when deleting last row
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSMutableArray *arrayForSectionAtIndexPath  = [self arrayForSelectedTaskAtIndexPath:indexPath];
    [arrayForSectionAtIndexPath removeObjectAtIndex:indexPath.row];
    
    if ([arrayForSectionAtIndexPath count]) [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    else [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    [self saveTasks];
    
  }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  
  NSMutableArray *arrayForTaskToMove = [self arrayForSelectedTaskAtIndexPath:sourceIndexPath];
  CATask *taskToMove = arrayForTaskToMove[sourceIndexPath.row];
  
  [arrayForTaskToMove removeObjectAtIndex:sourceIndexPath.row];
  [arrayForTaskToMove insertObject:taskToMove atIndex:destinationIndexPath.row];
  [self saveTasks];
  
}

#pragma mark IBActions

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender {
  [self performSegueWithIdentifier:@"addTaskViewControllerSegue" sender:sender];
}

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender {
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  [self.addBarButtonItem setEnabled:!self.tableView.editing];
}

#pragma mark - CAAddTaskViewController Delegate

-(void)didAddTask:(CATask *)task {
  
  if (!task.completion && ![self hasTaskDueDate:task.date passedDate:[NSDate date]]) [self.overdueTasks insertObject:task atIndex:0];
  else if (!task.completion && [self hasTaskDueDate:task.date passedDate:[NSDate date]]) [self.pendingTasks insertObject:task atIndex:0];
  else [self.completedTasks insertObject:task atIndex:0];
  
  NSMutableArray *savedTasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:SAVED_TASKS] mutableCopy];
  if (!savedTasksAsPropertyLists) savedTasksAsPropertyLists = [[NSMutableArray alloc] init];
  [savedTasksAsPropertyLists addObject:[self taskAsPropertyList:task]];
  [[NSUserDefaults standardUserDefaults] setObject:savedTasksAsPropertyLists forKey:SAVED_TASKS];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  [self dismissViewControllerAnimated:YES completion:nil];
  [self.tableView reloadData];
}

-(void)didCancel {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CADetailTaskViewController Delegate

-(void)updateTask {
  [self saveTasks];
  [self reloadDataSource];
  //[self loadSavedTasks];
  
  [self.tableView reloadData];
  NSLog(@"updateTask");
}

#pragma mark - Helper Methods

-(NSDictionary *)taskAsPropertyList:(CATask *)task {
  
  NSDictionary *propertyList = @{TASK_TITLE: task.title,
                                 TASK_DESCRIPTION: task.details,
                                 TASK_DATE: task.date,
                                 TASK_COMPLETION: [NSNumber numberWithBool:task.completion]};
  
  return propertyList;
}

-(CATask *)taskForDictionary:(NSDictionary *)dictionary {
  
  CATask *task = [[CATask alloc] initWithData:dictionary];
  return task;
}

-(void)saveTasks {
  
  NSMutableArray *tasks = [[NSMutableArray alloc] init];
  for (CATask *task in self.overdueTasks) {
    [tasks addObject:[self taskAsPropertyList:task]];
  }
  for (CATask *task in self.pendingTasks) {
    [tasks addObject:[self taskAsPropertyList:task]];
  }
  for (CATask *task in self.completedTasks) {
    [tasks addObject:[self taskAsPropertyList:task]];
  }
  [[NSUserDefaults standardUserDefaults] setObject:tasks forKey:SAVED_TASKS];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)reloadDataSource {
  [self.overdueTasks removeAllObjects];
  [self.pendingTasks removeAllObjects];
  [self.completedTasks removeAllObjects];
  for (CATask *task in self.savedTasks) {
    if (!task.completion && ![self hasTaskDueDate:task.date passedDate:[NSDate date]]) [self.overdueTasks addObject:task];
    else if (!task.completion && [self hasTaskDueDate:task.date passedDate:[NSDate date]]) [self.pendingTasks addObject:task];
    else [self.completedTasks addObject:task];
  }
}

- (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
  
  UIImage *image = [UIImage imageNamed:name];
  // Make a rectangle the size of your image
  CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
  // Create a new bitmap context based on the current image's size and scale, that has opacity
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
  // Get a reference to the current context (which you just created)
  CGContextRef c = UIGraphicsGetCurrentContext();
  // Draw your image into the context we created
  [image drawInRect:rect];
  // Set the fill color of the context
  CGContextSetFillColorWithColor(c, [color CGColor]);
  // This sets the blend mode, which is not super helpful. Basically it uses the your fill color with the alpha of the image and vice versa. I'll include a link with more info.
  CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
  // Now you apply the color and blend mode onto your context.
  CGContextFillRect(c, rect);
  // You grab the result of all this drawing from the context.
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  // And you return it.
  return result;
}

-(UIImage *)completionImageForTask:(CATask *)task AtDate:(NSDate *)date {
  
  if (![self hasTaskDueDate:task.date passedDate:[NSDate date]] && task.completion == NO) return [self imageNamed:@"cross" withColor:[UIColor redColor]];
  else if ([self hasTaskDueDate:task.date passedDate:[NSDate date]] && task.completion == NO) return [self imageNamed:@"clock" withColor:[UIColor yellowColor]];
  return [self imageNamed:@"check" withColor:[UIColor greenColor]];
}

-(BOOL)hasTaskDueDate:(NSDate *)taskDueDate passedDate:(NSDate *)date {
#warning not sure if correct
  NSTimeInterval taskDueDateInterval = [taskDueDate timeIntervalSince1970];
  NSTimeInterval dateInterval = [date timeIntervalSince1970];
  
  return taskDueDateInterval > dateInterval - 86400;
}

-(void)loadSavedTasks {
  for (NSDictionary *dictionary in [[NSUserDefaults standardUserDefaults] objectForKey:SAVED_TASKS]) {
    CATask *task = [self taskForDictionary:dictionary];
    [self.savedTasks addObject:task];
  }
}

-(CATask *)selectedTaskForSectionAtIndexPath:(NSIndexPath *)indexPath {
  
  CATask *selectedTask;
  NSMutableArray *arrayForTask;
  arrayForTask = [self arrayForSelectedTaskAtIndexPath:indexPath];
  selectedTask = arrayForTask[indexPath.row];
  
  return selectedTask;
}

-(NSMutableArray *)arrayForSelectedTaskAtIndexPath:(NSIndexPath *)indexPath {
  NSMutableArray *arrayForSelectedTask = [[NSMutableArray alloc] init];
  if (indexPath.section == 0) arrayForSelectedTask = self.overdueTasks;
  if (indexPath.section == 1) arrayForSelectedTask = self.pendingTasks;
  if (indexPath.section == 2) arrayForSelectedTask = self.completedTasks;
  
  return arrayForSelectedTask;
}
@end
