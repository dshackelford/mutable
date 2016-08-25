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
    
    //filler will never be called
    //there should be a filler string in the enemy pictures as well
    imageFileNames = @[@[@"base.png"],@[@"Snake.png"],@[@"filler",@"CircleShape.png",@"LineShape.png",@"SquareShape.png",@"TriangleShape"],@[@"mineImage2.png",@"blockadeElement.png",@"kamikaze.png",@"TurretGun.png"],@[@"lifePowerUp.png"]];
    
    self.navigationItem.title = @"HOW TO PLAY";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PLAY" style:UIBarButtonItemStylePlain target:self action:@selector(playButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"MAIN" style:UIBarButtonItemStylePlain target:self action:@selector(mainMenuButtonTapped:)];
}

-(IBAction)mainMenuButtonTapped:(id)sender
{
    //move to the main menu view controller to start playing
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LevelViewController* lvc = (LevelViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    lvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:lvc animated:YES completion:nil];
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
    return 55; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2)
    {
        return 55;
    }
    else
    {
        return 300; //really tall description cells
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    cell.mainLabel.text = [sectionTitles objectAtIndex:section];
    cell.mainLabel.font = [UIFont boldSystemFontOfSize:30];
    cell.mainLabel.textAlignment = NSTextAlignmentCenter;
    cell.mainLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    return cell;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2)
    {
        arrowCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"arrowCell" owner:self options:nil] lastObject];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        if (indexPath.row == 0 && indexPath.section == 2)
        {
            arrowCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"arrowCell" owner:self options:nil] lastObject];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            
            cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            return cell;
        }
        else
        {
            DescriptionView* cell = [[[NSBundle mainBundle] loadNibNamed:@"DescriptionView" owner:self options:nil] lastObject];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            
            cell.titleLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.titleLabel.textAlignment = NSTextAlignmentCenter;
            cell.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            
            cell.descriptionLabel.numberOfLines = 10;
            cell.descriptionLabel.text = [NSString stringWithFormat:@"WEll this is point number 1.\n this is should be on a nother line \n and this will be the third point, but it is also a really long sentence which should cause a problem for the phone table view to handle??????\n what if there is even more informtion, the label should just rise up, and allow this text to fill in, righ? i hope so."];
            
            NSLog(@"section:%ld, row:%ld",(long)indexPath.section,(long)indexPath.row);
            
            NSString* imgStr = [[imageFileNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            cell.descriptionImageView.image = [UIImage imageNamed:imgStr];
            
            //        cell.descriptionImageView.image = [UIImage imageNamed:@"kamikaze.png"];
            return cell;
        }

    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    self.selectedRow = (int)indexPath.row;
//    self.selectedSection = (int)indexPath.section;
//    self.actualSelectedIndex  = [self getActualIndex];
    
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