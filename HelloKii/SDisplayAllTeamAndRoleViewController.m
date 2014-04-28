//
//  SDisplayAllTeamAndRoleViewController.m
//  HelloKii
//
//  Created by saumya ray on 4/28/14.
//  Copyright (c) 2014 @saumya. All rights reserved.
//

#import "SDisplayAllTeamAndRoleViewController.h"

@interface SDisplayAllTeamAndRoleViewController ()

@end

@implementation SDisplayAllTeamAndRoleViewController

@synthesize loggedInUser;
@synthesize sListType;
@synthesize tvAllList;
@synthesize allDataFromBucket;

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
    if ([self.sListType isEqualToString:@"roles"]) {
        self.title = @"All Roles";
        [self renderRolesList];
    }else if([self.sListType isEqualToString:@"teams"]){
        self.title = @"All Teams";
        [self renderTeamsList];
    }
    //
    //Tableview
    //adding datasource and delegate
    self.tvAllList.delegate = self;
    self.tvAllList.dataSource = self;
    [self.tvAllList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    return self.allDataFromBucket.count;
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
    
    KiiObject *kObject = [self.allDataFromBucket objectAtIndex:indexPath.row];
    
    
    if ([self.sListType isEqualToString:@"teams"]) {
        cell.textLabel.text = [kObject getObjectForKey:@"teamName"];
    }else if([self.sListType isEqualToString:@"roles"]){
        cell.textLabel.text = [kObject getObjectForKey:@"positionName"];
    }
    
    //cell.textLabel.text = [kObject getObjectForKey:@"companyName"];
    //cell.detailTextLabel.text = [kObject getObjectForKey:@"companyURI"];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:didSelectRowAtIndexPath:");
    
}


#pragma mark - Utility
- (void) renderTeamsList
{
    NSLog(@"renderTeamList");
    self.allDataFromBucket = [SKii_Util getAllFromUserScope:self.loggedInUser
                                             WithBucketName:@"teams"];
    [self.tvAllList reloadData];
    
}

- (void) renderRolesList
{
    NSLog(@"renderRolesList");
    self.allDataFromBucket = [SKii_Util getAllFromUserScope:self.loggedInUser
                                             WithBucketName:@"positions"];
    [self.tvAllList reloadData];
}


@end
