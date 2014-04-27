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

#pragma mark - User

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

#pragma mark - Group
+ (NSString *) createGroupWithName:(NSString *)gName
{
    NSString *gURI = @"";
    
    NSError *error;
    //NSString *groupName = @"myGroup";
    NSString *groupName = gName;
    
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

+ (NSArray *) getAllGroupsCreatedByMe:(KiiUser *)user
{
    // Get the current login user
    //KiiUser* user = [KiiUser currentUser];
    
    NSError* error = nil;
    /*
    // Get a list of groups in which the current user is a member
    NSArray* memberGroups = [user memberOfGroupsSynchronous:&error];
    if (error == nil) {
        for (KiiGroup* group in memberGroups) {
            // do something with each group
        }
    } else {
        // Getting a group list failed
        // Please check error description/code to see what went wrong...
    }
    */
    // Get a list of groups in which the current user is a owner
    NSArray* ownerGroups = [user ownerOfGroupsSynchronous:&error];
    if (error == nil) {
        /*
        for (KiiGroup* group in ownerGroups) {
            // do something with each group
        }*/
        NSLog(@"SUCCESS : got groups.");
    } else {
        // Getting a group list failed
        // Please check error description/code to see what went wrong...
        NSLog(@"FAIL : got groups.");
        NSLog(@"%@",error);
    }
    return ownerGroups;
}

+(BOOL) deleteGroup:(KiiGroup *)group
{
    BOOL done =FALSE;
    
    NSError *error = nil;
    // Instantiate the group.
    // (Assume that groupUri has the reference URI of the target group).
    //KiiGroup *group = [KiiGroup groupWithURI:groupUri];
    
    // Delete the group.
    [group deleteSynchronous:&error];
    if (error != nil) {
        // Handle error.
        NSLog(@"FAIL : DELETE GROUP");
    }else{
        NSLog(@"SUCCESS : DELETE GROUP");
        done = TRUE;
    }
    
    return done;
}


#pragma mark - Bucket
+ (void) createBucketInUserScope:(KiiUser *)user WithName:(NSString *)bucketName
{
    NSLog(@"createBucketInUserScope:WithName: :TODO");
    // Create Application Scope Bucket
    //KiiBucket *bucket1 = [Kii bucketWithName:@"my_user"];
    
    // Create Group Scope Bucket
    //KiiGroup* group = [KiiGroup groupWithName:@"my_group"];
    //KiiBucket *bucket2 = [group bucketWithName:@"score_card"];
    
    // Create User Scope Bucket
    //KiiBucket *bucket3 = [[KiiUser currentUser] bucketWithName:@"my_private"];
    
    //Please Note: a bucket can not be explicitly saved,
    //it will only be created when an object is saved to it.
    //KiiObject *obj1 = [bucket1 createObject];
    //[obj1 saveSynchronous:&error];
    
    /*
    NSError *error;
    KiiBucket *bucket = [user bucketWithName:bucketName];
    KiiObject *obj1 = [bucket createObject];
    [obj1 setObject:@"easy" forKey:@"companyName"];
    [obj1 saveSynchronous:&error];
    
    if (error != nil) {
        NSLog(@"ERROR : creating bucket : in userscope.");
        NSLog(@"%@",error);
    }else{
        NSLog(@"SUCCESS : creating bucket :");
    }
    */
}

+ (NSMutableArray *) getAllFromUserScope:(KiiUser *)user WithBucketName:(NSString *)bucketName
{
    NSError *error = nil;
    //NSString *bucketName = @"companies";
    KiiBucket *bucket = [user bucketWithName:bucketName];
    KiiQuery *query = [KiiQuery queryWithClause:nil];
    
    NSMutableArray *allResults = [NSMutableArray array];
    KiiQuery *nextQuery;
    NSArray *results = [bucket executeQuerySynchronous:query
                                             withError:&error
                                               andNext:&nextQuery];
    [allResults addObjectsFromArray:results];
    if (error != nil) {
        NSLog(@"ERROR : getting data from Bucket=%@",bucketName);
        NSLog(@"%@",error);
    }else{
        NSLog(@"SUCCESS : getting data from Bucket");
    }
    return allResults;
}

#pragma mark - Bucket for companies
+ (BOOL)saveInUserScopeBucket:(KiiUser *)user CompanyName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error;
    NSString *bucketName = @"companies";
    
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiObject *obj = [bucket createObject];
    [obj setObject:name forKey:@"companyName"];
    [obj setObject:uri forKey:@"companyURI"];
    [obj saveSynchronous:&error];
    
    if (error != nil) {
        NSLog(@"ERROR : creating bucket : in userscope.");
        NSLog(@"%@",error);
    }else{
        NSLog(@"SUCCESS : creating bucket :");
        isDone = TRUE;
    }
    
    return isDone;
}

+ (BOOL)removeFromUserScopeBucket:(KiiUser *)user CompanyName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error = nil;
    NSString *bucketName = @"companies";
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiClause *clause1 = [KiiClause equals:@"companyName" value:name];
    KiiClause *clause2 = [KiiClause equals:@"companyURI" value:uri];
    KiiClause *totalClause = [KiiClause and:clause1, clause2, nil];
    
    KiiQuery *query = [KiiQuery queryWithClause:totalClause];
    
    NSMutableArray *allResults = [NSMutableArray array];
    KiiQuery *nextQuery;
    NSArray *results = [bucket executeQuerySynchronous:query
                                             withError:&error
                                               andNext:&nextQuery];
    [allResults addObjectsFromArray:results];
    
    //
    if (error != nil) {
        NSLog(@"removeFromUserScopeBucket:CompanyName:AndURI: ");
        NSLog(@"ERROR:Object not Found in Bucket.");
        NSLog(@"%@",error);
    }else{
        NSInteger index = 0;
        KiiObject *object = [allResults objectAtIndex:index];
        //
        //delete
        //KiiObject *object = [KiiObject objectWithURI:@"_URI_OF_THE_OBJECT_"];
        NSError *error1;
        [object deleteSynchronous:&error1];
        if(error1 != nil) {
            // Unable to delete object
            // Please check error description/code to see what went wrong...
            NSLog(@"removeFromUserScopeBucket:CompanyName:AndURI: ");
            NSLog(@"ERROR:Could not delete Object.");
            NSLog(@"%@",error1);
        }else{
            isDone = TRUE;
        }
    }
    
    return isDone;
}

#pragma mark - Bucket for positions
+ (BOOL)saveInUserScopeBucket:(KiiUser *)user PositionName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error;
    NSString *bucketName = @"positions";
    
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiObject *obj = [bucket createObject];
    [obj setObject:name forKey:@"positionName"];
    [obj setObject:uri forKey:@"positionURI"];
    [obj saveSynchronous:&error];
    
    if (error != nil) {
        NSLog(@"ERROR : creating bucket : in userscope.");
        NSLog(@"%@",error);
    }else{
        NSLog(@"SUCCESS : creating bucket :");
        isDone = TRUE;
    }
    
    return isDone;
}

+ (BOOL)removeFromUserScopeBucket:(KiiUser *)user PositionName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error = nil;
    NSString *bucketName = @"positions";
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiClause *clause1 = [KiiClause equals:@"positionName" value:name];
    KiiClause *clause2 = [KiiClause equals:@"positionURI" value:uri];
    KiiClause *totalClause = [KiiClause and:clause1, clause2, nil];
    
    KiiQuery *query = [KiiQuery queryWithClause:totalClause];
    
    NSMutableArray *allResults = [NSMutableArray array];
    KiiQuery *nextQuery;
    NSArray *results = [bucket executeQuerySynchronous:query
                                             withError:&error
                                               andNext:&nextQuery];
    [allResults addObjectsFromArray:results];
    
    //
    if (error != nil) {
        NSLog(@"removeFromUserScopeBucket:PositionName:AndURI: ");
        NSLog(@"ERROR:Object not Found in Bucket.");
        NSLog(@"%@",error);
    }else{
        NSInteger index = 0;
        KiiObject *object = [allResults objectAtIndex:index];
        //
        //delete
        //KiiObject *object = [KiiObject objectWithURI:@"_URI_OF_THE_OBJECT_"];
        NSError *error1;
        [object deleteSynchronous:&error1];
        if(error1 != nil) {
            // Unable to delete object
            // Please check error description/code to see what went wrong...
            NSLog(@"removeFromUserScopeBucket:PositionName:AndURI: ");
            NSLog(@"ERROR:Could not delete Object.");
            NSLog(@"%@",error1);
        }else{
            isDone = TRUE;
        }
    }
    
    return isDone;
}

#pragma mark - Bucket for teams
+ (BOOL)saveInUserScopeBucket:(KiiUser *)user TeamName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error;
    NSString *bucketName = @"teams";
    
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiObject *obj = [bucket createObject];
    [obj setObject:name forKey:@"teamName"];
    [obj setObject:uri forKey:@"teamURI"];
    [obj saveSynchronous:&error];
    
    if (error != nil) {
        NSLog(@"ERROR : creating bucket : in userscope.");
        NSLog(@"%@",error);
    }else{
        NSLog(@"SUCCESS : creating bucket :");
        isDone = TRUE;
    }
    
    return isDone;
}

+ (BOOL)removeFromUserScopeBucket:(KiiUser *)user TeamName:(NSString *)name AndURI:(NSString *)uri
{
    BOOL isDone = FALSE;
    
    NSError *error = nil;
    NSString *bucketName = @"teams";
    KiiBucket *bucket = [user bucketWithName:bucketName];
    
    KiiClause *clause1 = [KiiClause equals:@"teamName" value:name];
    KiiClause *clause2 = [KiiClause equals:@"teamURI" value:uri];
    KiiClause *totalClause = [KiiClause and:clause1, clause2, nil];
    
    KiiQuery *query = [KiiQuery queryWithClause:totalClause];
    
    NSMutableArray *allResults = [NSMutableArray array];
    KiiQuery *nextQuery;
    NSArray *results = [bucket executeQuerySynchronous:query
                                             withError:&error
                                               andNext:&nextQuery];
    [allResults addObjectsFromArray:results];
    
    //
    if (error != nil) {
        NSLog(@"removeFromUserScopeBucket:TeamName:AndURI: ");
        NSLog(@"ERROR:Object not Found in Bucket.");
        NSLog(@"%@",error);
    }else{
        NSInteger index = 0;
        KiiObject *object = [allResults objectAtIndex:index];
        //
        //delete
        //KiiObject *object = [KiiObject objectWithURI:@"_URI_OF_THE_OBJECT_"];
        NSError *error1;
        [object deleteSynchronous:&error1];
        if(error1 != nil) {
            // Unable to delete object
            // Please check error description/code to see what went wrong...
            NSLog(@"removeFromUserScopeBucket:TeamName:AndURI: ");
            NSLog(@"ERROR:Could not delete Object.");
            NSLog(@"%@",error1);
        }else{
            isDone = TRUE;
        }
    }
    
    return isDone;
}



@end
