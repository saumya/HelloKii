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

@synthesize loggedInUser;
@synthesize currentOrg;

@synthesize tPositionName;
@synthesize tTeamName;

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

-(void) onRemoveOrg:(id)sender
{
    NSLog(@"onTrashOrg");
    
    NSString *orgName = self.currentOrg.name;
    NSString *orgURI = [self.currentOrg objectURI];
    
    BOOL isDone = [SKii_Util deleteGroup:self.currentOrg];
    if(isDone == TRUE){
        NSLog(@"SUCCESS : DELETE");
        //Remove from the Bucket
        BOOL isDone1 = [SKii_Util removeFromUserScopeBucket:self.loggedInUser
                                                CompanyName:orgName
                                                     AndURI:orgURI];
        if (isDone1 == TRUE) {
            NSLog(@"SUCCESS: Removed from Bucket");
        }else{
            NSLog(@"FAIL : REMOVE from BUCKET!");
        }
    }else{
        NSLog(@"FAIL : DELETE");
    }
}

-(void) onAddTeam:(id)sender
{
    NSLog(@"onAddTeam : ");
    NSString *sName = self.tTeamName.text;
    NSString *uri = [SKii_Util createGroupWithName:sName];
    if ([uri isEqualToString:@""]) {
        NSLog(@"onCreateOrg : FAIL : Group Creation");
    }else{
        NSLog(@"onCreateOrg : SUCCESS : Group Creation");
        NSLog(@"group URI:%@",uri);
        //save in userscope bucket named : teams
        BOOL done = [SKii_Util saveInUserScopeBucket:self.loggedInUser
                                            TeamName:sName
                                              AndURI:uri];
        
        if (done == FALSE) {
            NSLog(@"Could not save to bucket");
        }else{
            NSLog(@"Saved to Bucket");
        }
    }
}

-(void) onAddRole:(id)sender
{
    NSLog(@"onAddRole");
    NSString *sName = self.tPositionName.text;
    NSString *uri = [SKii_Util createGroupWithName:sName];
    if ([uri isEqualToString:@""]) {
        NSLog(@"onCreateOrg : FAIL : Group Creation");
    }else{
        NSLog(@"onCreateOrg : SUCCESS : Group Creation");
        NSLog(@"group URI:%@",uri);
        //save in userscope bucket named : positions
        BOOL done = [SKii_Util saveInUserScopeBucket:self.loggedInUser
                                        PositionName:sName
                                              AndURI:uri];
        
        if (done == FALSE) {
            NSLog(@"Could not save to bucket");
        }else{
            NSLog(@"Saved to Bucket");
        }
    }
}
@end
