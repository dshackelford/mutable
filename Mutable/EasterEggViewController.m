//
//  EasterEggViewController.m
//  Mutable
//
//  Created by Dylan Shackelford on 8/25/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasterEggViewController.h"

@implementation EasterEggViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
    
    tableData = @[@"mu·ta·ble",
                  @"/ˈmyo͞otəbəl/",
                  @"adj: liable to change",
                  @" ",
                  @"//NSMutableArray in Objective-C \n@interface NSMutableArray : NSArray \n-(void)addObject: (id)anObject; \n@end",
                  @"DshackTech"];
    
    self.navigationItem.title = @"_DSHACKTECH";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PLAY" style:UIBarButtonItemStylePlain target:self action:@selector(playButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"MAIN" style:UIBarButtonItemStylePlain target:self action:@selector(mainMenuButtonTapped:)];
}

-(IBAction)mainMenuButtonTapped:(id)sender
{
    //move to the main menu view controller to start playing
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeView* lvc = (HomeView *)[storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0; // you can have your own choice, of course
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 4)
    {
        return 30;
    }
    else if(indexPath.row == 4)
    {
        return 175;
    }
    else if(indexPath.row == 5)
    {
        return 250;
        
    }
    else
    {
        return 150;
    }

}


//CELLS
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3)
    {
        HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        
        cell.mainLabel.text = [tableData objectAtIndex:indexPath.row];
        if (indexPath.row ==0)
        {
            cell.mainLabel.font = [UIFont boldSystemFontOfSize:30];
        }
        else if(indexPath.row == 1)
        {
            cell.mainLabel.font = [UIFont italicSystemFontOfSize:25];
        }
        else
        {
            cell.mainLabel.font = [UIFont systemFontOfSize:25];
        }
        
        cell.mainLabel.numberOfLines  = 10;
        
        cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
        
        cell.mainLabel.textColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row != 5)
    {

        HeaderCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCell" owner:self options:nil] lastObject];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        cell.mainLabel.text = [tableData objectAtIndex:indexPath.row];
        cell.mainLabel.font = [UIFont systemFontOfSize:20];
        cell.mainLabel.numberOfLines  = 10;
        
        cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
        
        cell.mainLabel.textColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        DescriptionView* cell = [[[NSBundle mainBundle] loadNibNamed:@"DescriptionView" owner:self options:nil] lastObject];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        cell.titleLabel.text =  [tableData objectAtIndex:indexPath.row];
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        cell.titleLabel.numberOfLines = 2;
        cell.descriptionLabel.text = @"Coming soon to the App Store:\nCross Hairs\nSurf Shack";
        
        cell.descriptionLabel.font = [UIFont systemFontOfSize:20];
        cell.descriptionLabel.numberOfLines  = 10;
        
        cell.backgroundColor = [UIColor colorWithRed:22/255.f green:119/255.f blue:205/255.f alpha:1];
        
        cell.descriptionLabel.textColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.descriptionImageView.image = [UIImage imageNamed:@"Small Logo.png"];
        
        return cell;
    }
    
}

@end