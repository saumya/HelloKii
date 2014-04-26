//
//  SEntryViewController.m
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import "SEntryViewController.h"

@interface SEntryViewController ()

@end

@implementation SEntryViewController

@synthesize lMessage;
@synthesize tUName;
@synthesize tUPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lMessage.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)onLogin:(id)sender
{
    NSString *un = self.tUName.text;
    NSString *up = self.tUPassword.text;
    KiiUser *loggedinUser = [SKii_Util loginUser:un WithPassword:up];
    NSLog(@"onLogin : %@",loggedinUser);
    if (loggedinUser == nil) {
        NSLog(@"FAIL : Login : No User found!");
        self.lMessage.text = @"Login : FAIL";
    }else{
        NSLog(@"SUCCESS : Login.");
        self.lMessage.text = @"Login : SUCCESS";
    }
}
-(void)onRegister:(id)sender
{
    NSString *un = self.tUName.text;
    NSString *up = self.tUPassword.text;
    KiiUser *registeredUser = [SKii_Util registerUser:un WithPassword:up];
    NSLog(@"onRegister : %@",registeredUser);
    if (registeredUser == nil) {
        NSLog(@"FAIL : Registration : No User found!");
        self.lMessage.text = @"Registration : FAIL";
    }else{
        NSLog(@"SUCCESS : Registration.");
        self.lMessage.text = @"Registration : SUCCESS";
    }
}

@end
