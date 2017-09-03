//
//  MUConstants.m
//  MatchedUp
//
//  Created by Christian Alsaybar on 18/03/14.
//  Copyright (c) 2014 Christian Alsaybar. All rights reserved.
//

#import "MUConstants.h"

@implementation MUConstants

#pragma mark - User Class

NSString *const kMUUserTagLineKey = @"tagLine";

NSString *const kMUUserProfileKey = @"profile";
NSString *const kMUUserProfileNameKey = @"name";
NSString *const kMUUserProfileFirstNameKey = @"firstName";
NSString *const kMUUserProfileLocation = @"location";
NSString *const kMUUserProfileGender = @"gender";
NSString *const kMUUserProfileBirthday = @"birthday";
NSString *const kMUUserProfileInterestedIn = @"interestedIn";
NSString *const kMUUserProfilePictureURL = @"pictureURL";
NSString *const KMUUSerProfileRelationshipStatusKey = @"relationshipStatus";
NSString *const KMUUserProfileAgeKey = @"age";

#pragma mark - Photo Class

NSString *const kMUPhotoClassKey = @"Photo";
NSString *const kMUPhotoUserKey = @"user";
NSString *const kMUPhotoPictureKey = @"image";

#pragma - mark Activity

NSString *const kMUActivityClassKey = @"Activity";
NSString *const kMUActivityTypeKey = @"type";
NSString *const kMUActivityFromUserKey = @"fromUser";
NSString *const kMUActivityToUserKey = @"toUser";
NSString *const kMUActivityPhotoKey = @"photo";
NSString *const kMUActivityTypeLikeKey = @"like";
NSString *const kMUActivityTypeDislikeKey = @"dislike";

NSString *const kMUMenEnabledKey = @"men";
NSString *const kMUWomenEnabledKey = @"women";
NSString *const kMUSingleEnabledKey = @"single";
NSString *const kMUAgeMaxKey = @"ageMax";

#pragma mark - ChatRoom

NSString *const kMUChatRoomClassKey = @"ChatRoom";
NSString *const kMUChatRoomUser1Key = @"user1";
NSString *const kMUChatRoomUser2Key = @"user2";

#pragma mark - Chat

NSString *const kMUChatClassKey = @"Chat";
NSString *const kMUChatChatroomKey = @"chatroom";
NSString *const kMUChatFromUserKey = @"fromUser";
NSString *const kMUChatToUserKey = @"toUser";
NSString *const kMUChatTextKey = @"text";

@end
