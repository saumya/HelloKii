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

@synthesize loggedinUser;

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
    KiiUser *user = [SKii_Util loginUser:un WithPassword:up];
    NSLog(@"onLogin : %@",user);
    if (user == nil) {
        NSLog(@"FAIL : Login : No User found!");
        self.lMessage.text = @"Login : FAIL";
    }else{
        NSLog(@"SUCCESS : Login.");
        self.loggedinUser = user;
        self.lMessage.text = @"Login : SUCCESS";
        [self performSegueWithIdentifier: @"segueToProfile" sender: self];
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

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"segueToProfile"])
    {
        // Get reference to the destination view controller
        SProfileViewController *vc = [segue destinationViewController];
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
        vc.loggedInUser=self.loggedinUser;
    }
}

@end
