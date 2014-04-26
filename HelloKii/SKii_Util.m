//
//  SKii_Util.m
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import "SKii_Util.h"

@implementation SKii_Util

//Kii details
//logged in as : saumya
//appname : HelloWorld

+ (void) initKii
{
    /*
    [Kii beginWithID:@"___APPID___"
              andKey:@"___APPKEY___"
             andSite:kiiSiteUS];
    */
    // Kii initialization
    [Kii beginWithID:@"4f239ee0"
              andKey:@"ebb8afe3966e2733e1dd7212469869c7"
             andSite:kiiSiteUS];
}

+ (KiiUser *) loginUser:(NSString *)uName WithPassword:(NSString *)uPass
{
    NSError *error;
    KiiUser *user =[KiiUser authenticateSynchronous:uName
                                       withPassword:uPass
                                           andError:&error];
    if (error != nil) {
        NSLog(@"ERROR : Login");
        NSLog(@"%@",error);
    }
    return user;
}

+ (KiiUser *) registerUser:(NSString *)uName WithPassword:(NSString *)uPass
{
    NSLog(@"registerUserWithUserName:%@ andPassword=%@",uName,uPass);
    NSError *error = nil;
    KiiUser *user = [KiiUser userWithUsername:uName andPassword:uPass];
    [user performRegistrationSynchronous:&error];
    if (error != nil) {
        NSLog(@"ERROR : Register");
        NSLog(@"%@",error);
    }
    return user;
}

+ (BOOL) updateProfile:(KiiUser *)user WithFirstname:(NSString *)fName AndLastname:(NSString *)lName
{
    NSLog(@"updateProfile:WithFirstname:AndLastname:");
    BOOL isDone = FALSE;
    NSError *error = nil;
    //KiiUser *user = [KiiUser currentUser];
    //default fields
    NSString *dName = [NSString stringWithFormat:@"%@ %@",fName,lName];
    [user setDisplayName:dName];
    //custom fields
    [user setObject:fName forKey:@"firstName"];
    [user setObject:lName forKey:@"lastName"];
    
    [user saveSynchronous:&error];
    if (error != nil) {
        NSLog(@"ERROR : Updating data");
        NSLog(@"%@",error);
    }else{
        isDone = TRUE;
    }
    return isDone;
}

+ (NSString *) createGroupWithName:(NSString *)gName
{
    NSString *gURI = @"";
    
    NSError *error;
    NSString *groupName = @"myGroup";
    
    KiiGroup* group = [KiiGroup groupWithName:groupName];
    [group saveSynchronous:&error];
    
    if (error != nil) {
        // Group creation failed
        // Please check error description/code to see what went wrong...
        NSLog(@"ERROR : creating group.");
    }else{
        NSLog(@"SUCCESS : creating group.");
        gURI = [group objectURI];
    }
    
    // Get the reference URI.
    //NSString *groupUri = [group objectURI];
    return gURI;
}


@end
