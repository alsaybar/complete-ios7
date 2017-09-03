//
//  MUConstants.h
//  MatchedUp
//
//  Created by Christian Alsaybar on 18/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUConstants : NSObject

#pragma mark - User Class

extern NSString *const kMUUserTagLineKey;

extern NSString *const kMUUserProfileKey;
extern NSString *const kMUUserProfileNameKey;
extern NSString *const kMUUserProfileFirstNameKey;
extern NSString *const kMUUserProfileLocation;
extern NSString *const kMUUserProfileGender;
extern NSString *const kMUUserProfileBirthday;
extern NSString *const kMUUserProfileInterestedIn;
extern NSString *const kMUUserProfilePictureURL;
extern NSString *const KMUUSerProfileRelationshipStatusKey;
extern NSString *const KMUUserProfileAgeKey;

#pragma mark - Photo Class

extern NSString *const kMUPhotoClassKey;
extern NSString *const kMUPhotoUserKey;
extern NSString *const kMUPhotoPictureKey;

#pragma - mark Activity

extern NSString *const kMUActivityClassKey;
extern NSString *const kMUActivityTypeKey;
extern NSString *const kMUActivityFromUserKey;
extern NSString *const kMUActivityToUserKey;
extern NSString *const kMUActivityPhotoKey;
extern NSString *const kMUActivityTypeLikeKey;
extern NSString *const kMUActivityTypeDislikeKey;

#pragma mark - Settings

extern NSString *const kMUMenEnabledKey;
extern NSString *const kMUWomenEnabledKey;
extern NSString *const kMUSingleEnabledKey;
extern NSString *const kMUAgeMaxKey;

#pragma mark - ChatRoom

extern NSString *const kMUChatRoomClassKey;
extern NSString *const kMUChatRoomUser1Key;
extern NSString *const kMUChatRoomUser2Key;

#pragma mark - Chat

extern NSString *const kMUChatClassKey;
extern NSString *const kMUChatChatroomKey;
extern NSString *const kMUChatFromUserKey;
extern NSString *const kMUChatToUserKey;
extern NSString *const kMUChatTextKey;

@end
