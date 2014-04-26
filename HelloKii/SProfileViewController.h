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
{
    //
}

@property (nonatomic, retain) KiiUser *loggedInUser;

@property (nonatomic, retain) IBOutlet UITextField *tFName;
@property (nonatomic, retain) IBOutlet UITextField *tLName;

- (IBAction)onUpdateProfile:(id)sender;

@end
