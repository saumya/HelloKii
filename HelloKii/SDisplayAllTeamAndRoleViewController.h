//
//  SDisplayAllTeamAndRoleViewController.h
//  HelloKii
//
//  Created by saumya ray on 4/28/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/Kii.h>

@interface SDisplayAllTeamAndRoleViewController : UIViewController
{
    //
}

@property (nonatomic,retain) KiiUser *loggedInUser;
@property (nonatomic,retain) NSString *sListType;//roles or teams

@end
