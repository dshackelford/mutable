//
//  HowToPlayViewController.m
//  Mutable
//
//  Created by Dylan Shackelford on 8/12/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HowToPlayViewController.h"

@implementation HowToPlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    rowHeight = 55;
    
    tableData = @[@[@"Destroy the enemy base and grab the gem inside"],@[@"the snake can move up,down,left, or right. Just wipe anywere to change direction",@"Ammo = snake length; shown in top left corner."],@[@"Shape shifting is how you attack and defend. Tap to where you want to shoot!",@"Circle",@"Line",@"Square",@"Triangle"],@[@"Mine",@"Blockade",@"Drone",@"Turret Gun"],@[@"Food gives you an extra 15 links to your snake. Run snake over them to eat."]];
    
    sectionTitles = @[@"OBJECTIVE",@"SNAKE MOVEMENT",@"SHAPE SHIFTING",@"ENEMIES",@"POWER UPS"];
    
    self.navigationItem.title = @"HOW TO PLAY";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PLAY" style:UIBarButtonItemStylePlain target:self action:@selector(playButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SETTINGS" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonTapped:)];
}

-(IBAction)playButtonTapped:(id)sender
{
    //move to the level view controller to start playing
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LevelViewController* lvc = (LevelViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PlayView"];
    lvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:lvc animated:YES completion:nil];
}

-(IBAction)settingsButtonTapped:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsViewController* lvc = (SettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    lvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:lvc animated:YES completion:nil];
}

#pragma mark - UITableViewProtocols
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitles count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) //objective
    {
        return 1;
    }
    else if(section == 1)//snake movement
    {
        return 2;
    }
    else if(section == 2)//shape shifting
    {
        return 5;
    }
    else if(section == 3)//Enemies
    {
        return 4;
    }
    else //Power Ups
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"Header";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:HeaderCellIdentifier];
    
    cell.backgroundColor = [UIColor blueColor]; //make this the RGB of the color that is always used
    
    cell.textLabel.text = [sectionTitles objectAtIndex:section];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    arrowCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"arrowCell" owner:self options:nil] lastObject];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
//    if (indexPath.row == 3)
//    {
//        UISwitch* aSwicth= [[UISwitch alloc] initWithFrame:CGRectZero];
//        [cell addSubview:aSwicth];
//        [cell setAccessoryView:aSwicth];
//    }
//    else
//    {
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]; //the grey chevron
//    }
    
    //    cell.imageView.image = [UIImage imageNamed:@"units.png"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedRow = (int)indexPath.row;
    self.selectedSection = (int)indexPath.section;
    self.actualSelectedIndex  = [self getActualIndex];
    
}

-(int)getActualIndex
{
    int rowCount = 0;
    
    for (int i = 0; i < self.selectedSection; i++)
    {
        rowCount = rowCount + [self.tableView numberOfRowsInSection:i];
    }
    
    rowCount = rowCount + self.selectedRow;
    
    return  rowCount;
}



@end