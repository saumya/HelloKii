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
@synthesize allMyCreatedOrgs;
@synthesize userSelectedGroup;

@synthesize tFName;
@synthesize tLName;
@synthesize tOrgName;
@synthesize tvAllMyOrgs;

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
    self.tFName.text = [self.loggedInUser getObjectForKey:@"firstName"];
    self.tLName.text = [self.loggedInUser getObjectForKey:@"lastName"];
    //
    [self pullDataFromKii];
    //
    //Tableview
    //adding datasource and delegate
    self.tvAllMyOrgs.delegate = self;
    self.tvAllMyOrgs.dataSource = self;
    [self.tvAllMyOrgs registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    

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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.allMyCreatedOrgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //cell = [self tableCellWithHeight:height clickable:NO withArrowAccessory:NO];
    
    // Configure the cell...
    //cell.textLabel.text = @"world";
    //cell.detailTextLabel.text = @"hello";
    
    //KiiGroup *kGroup= [self.allMyCreatedOrgs objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [uObj getObjectForKey:@"userName"];
    //cell.detailTextLabel.text = [uObj getObjectForKey:@"teamName"];
    
    //cell.textLabel.text = kGroup.name;
    //cell.detailTextLabel.text = [kGroup objectURI];
    
    KiiObject *kObject = [self.allMyCreatedOrgs objectAtIndex:indexPath.row];
    cell.textLabel.text = [kObject getObjectForKey:@"companyName"];
    //cell.detailTextLabel.text = [kObject getObjectForKey:@"companyURI"];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:didSelectRowAtIndexPath:");
    
    //get data
    //KiiObject *uObj= [self.aUserList objectAtIndex:indexPath.row];
    //self.selectedUser = uObj;
    //NSLog(@"%@",uObj);
    //NSLog(@"%@",[uObj getObjectForKey:@"userName"]);
    //
    //self.selectedUserData=uObj;
    //execute segue programmatically
    //[self performSegueWithIdentifier: @"segueToUserDetailView" sender: self];
    /*
    KiiGroup *kGroup = [self.allMyCreatedOrgs objectAtIndex:indexPath.row];
    NSLog(@"selectedGroup :%@",kGroup);
    //NSLog(@"Org Name = %@",kGroup.name);
    self.userSelectedGroup = kGroup;
    */
    KiiObject *kObject = [self.allMyCreatedOrgs objectAtIndex:indexPath.row];
    NSLog(@"selectedOrg :%@",kObject);
    //NSLog(@"Org Name = %@",kGroup.name);
    NSString *gURI = [kObject getObjectForKey:@"companyURI"];
    //
    NSError *error;
    // Instantiate the group again.
    // (Assume that groupUri has the reference URI of the target group).
    KiiGroup *group = [KiiGroup groupWithURI:gURI];
    // Refresh the instance to make it up-to-date.
    [group refreshSynchronous:&error];
    if (error != NULL) {
        // Handle error.
        NSLog(@"ERROR : Refreshing the group!");
    }else{
        NSLog(@"SUCCESS : Refreshing the group!");
    }
    
    // Do something with the group reference.
    // NSString *groupName = group.name;
    //
    
    self.userSelectedGroup = group;
    
    //move to next view
    [self performSegueWithIdentifier:@"segueToOrg" sender:self];
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToOrg"])
    {
        SOrgViewController *vc = [segue destinationViewController];
        vc.loggedInUser = self.loggedInUser;
        vc.currentOrg = self.userSelectedGroup;
    }
}

#pragma mark - Utility
-(void)pullDataFromKii
{
    //NSArray *myCreatedGroups = [SKii_Util getAllGroupsCreatedByMe:self.loggedInUser];
    //self.allMyCreatedOrgs = [NSMutableArray arrayWithArray:myCreatedGroups];
    
    NSMutableArray *myCreatedCompanies = [SKii_Util getAllFromUserScope:self.loggedInUser WithBucketName:@"companies"];
    NSLog(@"result=%@",myCreatedCompanies);
    self.allMyCreatedOrgs = myCreatedCompanies;
}

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

-(void)onCreateOrg:(id)sender
{   
    NSString *sName = self.tOrgName.text;
    NSString *groupURI = [SKii_Util createGroupWithName:sName];
    if ([groupURI isEqualToString:@""]) {
        NSLog(@"onCreateOrg : FAIL : Group Creation");
    }else{
        NSLog(@"onCreateOrg : SUCCESS : Group Creation");
        NSLog(@"group URI:%@",groupURI);
        //save in userscope bucket named : companies
        BOOL done = [SKii_Util saveInUserScopeBucket:self.loggedInUser
                                         CompanyName:sName
                                              AndURI:groupURI];
        if (done == FALSE) {
            NSLog(@"Could not save to bucket");
        }else{
            NSLog(@"Saved to Bucket");
        }
    }
}

@end
