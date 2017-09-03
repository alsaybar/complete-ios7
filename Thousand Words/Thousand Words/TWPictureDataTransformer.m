//
//  TWPictureDataTransformer.m
//  Thousand Words
//
//  Created by Christian Alsaybar on 16/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "TWPictureDataTransformer.h"

@implementation TWPictureDataTransformer

+(Class)transformedValueClass {
  
  return [NSData class];
}

+(BOOL)allowsReverseTransformation {
  
  return YES;
}

-(id)transformedValue:(id)value {
  
  return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value {
  
  return [UIImage imageWithData:value];
}

@end
