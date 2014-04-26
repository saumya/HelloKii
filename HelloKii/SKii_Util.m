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


@end
