//
//  MUTransitionAnimator.h
//  MatchedUp
//
//  Created by Christian Alsaybar on 22/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

@end
