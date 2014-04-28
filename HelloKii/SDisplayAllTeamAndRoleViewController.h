//
//  SDisplayAllTeamAndRoleViewController.h
//  HelloKii
//
//  Created by saumya ray on 4/28/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/Kii.h>
#import "SKii_Util.h"

@interface SDisplayAllTeamAndRoleViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    //
}

@property (nonatomic,retain) KiiUser *loggedInUser;
@property (nonatomic,retain) NSString *sListType;//roles or teams

@property (retain, nonatomic) IBOutlet UITableView *tvAllList;

@property (nonatomic, retain) NSMutableArray *allDataFromBucket;

@end
