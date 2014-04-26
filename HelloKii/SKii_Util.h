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


@end
