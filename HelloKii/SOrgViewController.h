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

@interface SOrgViewController : UIViewController
{
    //
}

@property (nonatomic,retain) KiiGroup *currentOrg;
- (IBAction) onTrashOrg:(id)sender;

@end
