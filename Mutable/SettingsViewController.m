//
//  SettingsViewController.m
//  Mutable
//
//  Created by Dylan Shackelford on 8/12/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewController.h"

@implementation SettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    rowHeight = 55;
    
    tableData = @[@"Restart From Zero",@"Difficulty Setting"];
    
    self.navigationItem.title = @"SETTINGS";
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


#pragma mark - UITableViewProtocols
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0; // you can have your own choice, of course
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

    cell.textLabel.text = @"Hello";
    return cell;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    arrowCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"arrowCell" owner:self options:nil] lastObject];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    
//  cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    if (indexPath.row == 3)
    {
        UISwitch* aSwicth= [[UISwitch alloc] initWithFrame:CGRectZero];
        [cell addSubview:aSwicth];
        [cell setAccessoryView:aSwicth];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]; //the grey chevron
    }
    
    //    cell.imageView.image = [UIImage imageNamed:@"units.png"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedRow = indexPath.row;
    
    if (indexPath.row == 0)
    {
        [self performSelector:@selector(didPressRestartButton:) withObject:nil];
        [self performSelector:@selector(playButtonTapped:) withObject:nil];
    }
    else
    {
        //go into another view controller
        [self performSegueWithIdentifier:@"showDifficultyView" sender:self];
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //segmented control settings
    if ([segue.identifier isEqualToString:@"showDifficultyView"])
    {
        SubSettingsViewController *destViewController = segue.destinationViewController;
        
        [destViewController setTableData:@[@"Easy",@"Medium",@"Hard"]];
        
        [destViewController setTitle:[tableData objectAtIndex:self.selectedRow]];
    }
}

-(IBAction)didPressRestartButton:(id)sender
{
    NSMutableDictionary* dictionaryFromFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [dictionaryFromFile setObject:@"0" forKey:@"currentLevel"];
    [dictionaryFromFile setObject:@"50" forKey:@"snakeLength"];
    [dictionaryFromFile writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES ];
}


-(IBAction)didPressEasyButton:(id)sender
{
    difficultySetting = @"Easy";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Easy" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
//    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
//    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}

-(IBAction)didPressMediumButton:(id)sender
{
    difficultySetting = @"Medium";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Medium" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
//    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
//    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}

-(IBAction)didPressHardButton:(id)sender
{
    difficultySetting = @"Hard";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Hard" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
//    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
}


@end