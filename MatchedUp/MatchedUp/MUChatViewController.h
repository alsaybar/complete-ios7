//
//  MUChatViewController.h
//  MatchedUp
//
//  Created by Christian Alsaybar on 19/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface MUChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatRoom;

@end
