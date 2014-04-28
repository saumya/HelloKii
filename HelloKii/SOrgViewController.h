//
//  SOrgViewController.h
//  HelloKii
//
//  Created by saumya ray on 4/27/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/Kii.h>

#import "SKii_Util.h"
#import "SDisplayAllTeamAndRoleViewController.h"

@interface SOrgViewController : UIViewController
{
    //
}

@property (nonatomic, retain) KiiUser *loggedInUser;
@property (nonatomic, retain) KiiGroup *currentOrg;

@property (nonatomic, retain) IBOutlet UITextField *tPositionName;
@property (nonatomic, retain) IBOutlet UITextField *tTeamName;

- (IBAction) onRemoveOrg:(id)sender;

- (IBAction) onAddTeam:(id)sender;
- (IBAction) onAddRole:(id)sender;

- (IBAction) onViewTeams:(id)sender;
- (IBAction) onViewRoles:(id)sender;
@property (nonatomic, retain) NSString *sGoingToView;//teams or roles

@end
