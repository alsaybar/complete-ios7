//
//  TWPhotosCollectionViewController.m
//  Thousand Words
//
//  Created by Christian Alsaybar on 16/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "TWPhotosCollectionViewController.h"
#import "TWPhotoCollectionViewCell.h"
#import "Photo.h"
#import "TWPictureDataTransformer.h"
#import "TWCoreDataHelper.h"
#import "TWPhotoDetailViewController.h"

@interface TWPhotosCollectionViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSMutableArray *photos;

@end

@implementation TWPhotosCollectionViewController

-(NSMutableArray *)photos {
  
  if (!_photos) {
    _photos = [[NSMutableArray alloc] init];
  }
  return _photos;
}

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
}

-(void)viewWillAppear:(BOOL)animated {
  
  [super viewWillAppear:YES];
  
  NSSet *unorderedPhotos = self.album.photos;
  NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
  NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
  self.photos = [sortedPhotos mutableCopy];
  
  [self.collectionView reloadData];
  
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@"detailSegue"]) {
    if ([segue.destinationViewController isKindOfClass:[TWPhotoDetailViewController class]]) {
      TWPhotoDetailViewController *targetViewController = segue.destinationViewController;
      NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
      
      Photo *selectedPhoto = self.photos[indexPath.row];
      targetViewController.photo = selectedPhoto;
    }
  }
}

#pragma mark - IBActions

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender {
  
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  imagePicker.delegate = self;
  
//  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//  } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//  }
  [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Helper Methods

-(Photo *)photoFromImage:(UIImage *)image {
  
  Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDataHelper managedObjectContext]];
  photo.image = image;
  photo.date = [NSDate date];
  photo.albumBook = self.album;
  
  NSError *error = nil;
  
  if (![[photo managedObjectContext] save:&error]) {
    //Some error occured
    NSLog(@"%@", error);
  }
  
  return photo;
}

#pragma mark - UICollectionView Data Source

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *cellIdentifier = @"Photo Cell";
  
  TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
  
  
  
  
  dispatch_queue_t photoCollectionQueue = dispatch_queue_create("photo collection queue", NULL);
  
  dispatch_async(photoCollectionQueue, ^{
    Photo *photo = self.photos[indexPath.row];
    // Pushing UI changes back to main thead (must be done!)
    dispatch_async(dispatch_get_main_queue(), ^{
      cell.backgroundColor = [UIColor whiteColor];
      cell.imageView.image = photo.image;
    });
  });

  
  return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return [self.photos count];
}

#pragma mark - UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
  
  
  
  dispatch_queue_t imagePickerQueue = dispatch_queue_create("image picker queue", NULL);
  
  dispatch_async(imagePickerQueue, ^{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    [self.photos addObject:[self photoFromImage:image]];
    [self.collectionView reloadData];
    // Pushing UI changes back to main thead (must be done!)
    dispatch_async(dispatch_get_main_queue(), ^{
      
      
      NSLog(@"Finished Picking");
      [self dismissViewControllerAnimated:YES completion:nil];
    });
  });
  
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  
  NSLog(@"Cancel");
  [self dismissViewControllerAnimated:YES completion:nil];
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


@end
