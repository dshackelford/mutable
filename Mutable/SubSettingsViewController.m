//
//  SubSettingsViewController.m
//  Mutable
//
//  Created by Dylan Shackelford on 8/23/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import "SubSettingsViewController.h"

@implementation SubSettingsViewController

-(void)viewDidLoad
{
    screenSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    
    //removes the lines around cells not being used!
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTableData:(NSArray*)dataArrayInit
{
    tableData = dataArrayInit;
}

-(void)setTitle:(NSString *)titleInit
{
    self.navigationItem.title = titleInit;
}


#pragma mark - Table Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    arrowCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"arrowCell" owner:self options:nil] lastObject];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    //check from preference file which one to checkmark
    if (indexPath.row == 0)
    {
           [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }


    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    [cell setTintColor:[UIColor whiteColor]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType != UITableViewCellAccessoryCheckmark)
    {
        //set this to the difficulty in the setting file
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //not complete
    }
    
}


@end
