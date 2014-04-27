//
//  SKii_Util.h
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KiiSDK/Kii.h>

@interface SKii_Util : NSObject
{
    //
}

+ (void) initKii;
+ (KiiUser *) loginUser:(NSString *)uName WithPassword:(NSString *)uPass;
+ (KiiUser *) registerUser:(NSString *)uName WithPassword:(NSString *)uPass;
+ (BOOL) updateProfile:(KiiUser *)user WithFirstname:(NSString *)fName AndLastname:(NSString *)lName;

+ (NSString *) createGroupWithName:(NSString *)gName;
+ (NSArray *) getAllGroupsCreatedByMe:(KiiUser *)user;
+ (BOOL) deleteGroup:(KiiGroup *)group;

+ (void) createBucketInUserScope:(KiiUser *)user WithName:(NSString *)bucketName;
+ (NSMutableArray *) getAllFromUserScope:(KiiUser *)user WithBucketName:(NSString *)bucketName;

+ (BOOL) saveInUserScopeBucket:(KiiUser *)user CompanyName:(NSString *)name AndURI:(NSString *)uri;
+ (BOOL) removeFromUserScopeBucket:(KiiUser *)user CompanyName:(NSString *)name AndURI:(NSString *)uri;

+ (BOOL)saveInUserScopeBucket:(KiiUser *)user PositionName:(NSString *)name AndURI:(NSString *)uri;
+ (BOOL)removeFromUserScopeBucket:(KiiUser *)user PositionName:(NSString *)name AndURI:(NSString *)uri;

+ (BOOL)saveInUserScopeBucket:(KiiUser *)user TeamName:(NSString *)name AndURI:(NSString *)uri;
+ (BOOL)removeFromUserScopeBucket:(KiiUser *)user TeamName:(NSString *)name AndURI:(NSString *)uri;




@end
