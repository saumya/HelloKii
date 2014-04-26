//
//  SProfileViewController.m
//  HelloKii
//
//  Created by saumya ray on 4/26/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import "SProfileViewController.h"

@interface SProfileViewController ()

@end

@implementation SProfileViewController

@synthesize loggedInUser;

@synthesize tFName;
@synthesize tLName;

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
    self.title = self.loggedInUser.username;
    //self.navigationItem.prompt = self.loggedInUser.username;
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

-(void)onUpdateProfile:(id)sender
{
    NSString *firstName = self.tFName.text;
    NSString *lastName = self.tLName.text;
    BOOL isDone = [SKii_Util updateProfile:self.loggedInUser
                             WithFirstname:firstName AndLastname:lastName];
    if (isDone==TRUE) {
        NSLog(@"Success : Profile update.");
    }else{
        NSLog(@"FAIL : Profile update.");
    }
}

@end
