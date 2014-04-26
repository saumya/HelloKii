//
//  SEntryViewController.h
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/Kii.h>
#import "SKii_Util.h"

@interface SEntryViewController : UIViewController
{
    //
}

@property (nonatomic, retain) IBOutlet UILabel *lMessage;
@property (nonatomic, retain) IBOutlet UITextField *tUName;
@property (nonatomic, retain) IBOutlet UITextField *tUPassword;
-(IBAction)onRegister:(id)sender;
-(IBAction)onLogin:(id)sender;

@end
