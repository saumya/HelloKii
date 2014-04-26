//
//  SProfileViewController.h
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/Kii.h>
#import "SKii_Util.h"

@interface SProfileViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    //
}

@property (nonatomic, retain) KiiUser *loggedInUser;
@property (nonatomic, retain) NSMutableArray *allMyCreatedOrgs;

@property (nonatomic, retain) IBOutlet UITextField *tFName;
@property (nonatomic, retain) IBOutlet UITextField *tLName;

@property (nonatomic, retain) IBOutlet UITextField *tOrgName;
@property (retain, nonatomic) IBOutlet UITableView *tvAllMyOrgs;

- (IBAction)onUpdateProfile:(id)sender;
- (IBAction)onCreateOrg:(id)sender;


@end
