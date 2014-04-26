//
//  SOrgViewController.m
//  HelloKii
//
//  Created by saumya ray on 4/27/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import "SOrgViewController.h"

@interface SOrgViewController ()

@end

@implementation SOrgViewController

@synthesize currentOrg;

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
    self.title = self.currentOrg.name;
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

#pragma mark - User Action

-(void) onTrashOrg:(id)sender
{
    NSLog(@"onTrashOrg");
    BOOL isDone = [SKii_Util deleteGroup:self.currentOrg];
    if(isDone == TRUE){
        NSLog(@"SUCCESS : DELETE");
    }else{
        NSLog(@"FAIL : DELETE");
    }
}

@end
