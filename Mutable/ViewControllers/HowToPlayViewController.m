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
    
    self.tableView.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    tableData = @[@[@"To destroy the enemy base and grab the gem inside by shape shifting and avoiding enemy obstacles!"],
                  @[@"The snake can move up, down, left, or right. Just swipe anywhere to change direction of travel.",@"Your snake is your ammo: the longer your snake, the more you can shoot! Ammo count is shown in top left corner."],
                  @[@"Shape shifting is how you attack and defend. Enter into an availab shape through the touch interactions listed below. When in shape shift mode, TAP WHERE YOU want you want shoot!", @"Circle",@"Line",@"Square",@"Triangle"],
                  @[@"Mine",@"Blockade",@"Drone",@"Turret Gun"],
                  @[@"Food"]];
    
    sectionTitles = @[@"OBJECTIVE",@"SNAKE MOVEMENT",@"SHAPE SHIFTING",@"ENEMIES",@"POWER UPS"];
    
    //filler will never be called
    //there should be a filler string in the enemy pictures as well
    descriptions = @[@[@"filler"],@[@"filler"],
                     @[@"filler",@"How: Tap and Hold \nAvailable: Always\nSpecialty: None (shoots one bullet at a time).",
                     @"How: Pinch\nAvailable: Level 6 \nSepcialty: Show hidden mines and hide from drones\nWeakness: No fire capabilties.",
                     @"How: Two finger double tap \nAvailable: Level 8\nSpecialty: Shoots double bullets (double bullets more faster and cover more area per shot then normal bullets).",
                     @"How: Two finder tap and hold \nAvailable: Level 13\nSpecialty: Allows wall building (see below)!",
                     @"How: Tap and hold until ammo count turns green, then move finder to add links to wall. \nAvailable: Level 16"],
                    @[@"Type: Basic Enemy \nDamage: Kills on contact. \nAvailable: Level 1.",
                      @"Type: Moving Enemy Blockade. \nDamage: Cuts snake at point of contact.\nAvailable: Level 3.",
                      @"Type: Tracker Enemy\nDamage: Cuts snake at point of contact. Tracks your headlink's (the white dot) position.\nAvailable: Level 17",
                      @"Type:Enemy Shooter\nDamage: Cuts enemy at point of contact. Turret gun fires at last know headlink position, so beware! \nAvailable: Level 13"],
                     @[@"Gives you an extra 15 links to your snake. Run snake over them to eat to get more links! This helps you shoot more bullets to get the gem!"]];
    
    imageFileNames = @[@[@"base.png"],@[@"Snake.png"],@[@"filler",@"CircleShape.png",@"LineShape.png",@"SquareShape.png",@"TriangleShape"],@[@"mineImage2.png",@"blockadeElement.png",@"newKamikaze.png",@"TurretGun.png"],@[@"lifePowerUp.png"]];
    
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
    return 45; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2)
    {
        return 90;
    }
    else if(indexPath.section == 2 && indexPath.row == 0)
    {
        return 130;
    }
    else
    {
        return 250;
    }
}

//HEADERS
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIView* topSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 5)];/// change size as you need.
    UIView* bottomSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 5, tableView.frame.size.width, 5)];
    topSeparatorLineView.backgroundColor = [UIColor whiteColor];
    bottomSeparatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
    
    [cell.contentView addSubview:topSeparatorLineView];
    [cell.contentView addSubview:bottomSeparatorLineView];
    
    
    cell.mainLabel.text = [sectionTitles objectAtIndex:section];
    cell.mainLabel.font = [UIFont boldSystemFontOfSize:30];
    cell.mainLabel.textAlignment = NSTextAlignmentCenter;
    cell.mainLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    return cell;
}

//CELLS
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 2)
    {
        HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        cell.mainLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.mainLabel.font = [UIFont systemFontOfSize:18];
        cell.mainLabel.numberOfLines  = 10;
        
        cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
        
        cell.mainLabel.textColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {   //FIRST ROW HAS NO IMAGE, ONLY A DESCRIPTION
        if (indexPath.row == 0 && indexPath.section == 2)
        {
            HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
            
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            cell.mainLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            cell.mainLabel.numberOfLines = 10;
            cell.mainLabel.textColor = [UIColor whiteColor];
            cell.mainLabel.font = [UIFont systemFontOfSize:18];
            
            cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            UIView* topSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 2.5)];/// change size as you need.
            UIView* bottomSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 2.5, tableView.frame.size.width, 2.5)];
            topSeparatorLineView.backgroundColor = [UIColor whiteColor];
            bottomSeparatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
            
//            [cell.contentView addSubview:topSeparatorLineView];
//            [cell.contentView addSubview:bottomSeparatorLineView];
            
            
            return cell;
        }
        else
        {
            DescriptionView* cell = [[[NSBundle mainBundle] loadNibNamed:@"DescriptionView" owner:self options:nil] lastObject];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            UIView* topSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 2.5)];/// change size as you need.
            UIView* bottomSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 2.5, tableView.frame.size.width, 2.5)];
            topSeparatorLineView.backgroundColor = [UIColor whiteColor];
            bottomSeparatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
            
//            [cell.contentView addSubview:topSeparatorLineView];
//            [cell.contentView addSubview:bottomSeparatorLineView];
            
            //TITLE TABLE
            cell.titleLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.titleLabel.textAlignment = NSTextAlignmentCenter;
            cell.titleLabel.font = [UIFont boldSystemFontOfSize:25];
            cell.titleLabel.textColor = [UIColor whiteColor];
            
            //DESCRIPTION LABLE
            cell.descriptionLabel.numberOfLines = 10;
            
            cell.descriptionLabel.text = [[descriptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.descriptionLabel.textColor = [UIColor whiteColor];
            cell.descriptionLabel.font = [UIFont systemFontOfSize:18];
            
            //IMAGE VIEW
            NSString* imgStr = [[imageFileNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            cell.descriptionImageView.image = [UIImage imageNamed:imgStr];
            
            cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }

    }

}


@end