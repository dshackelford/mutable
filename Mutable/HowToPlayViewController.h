//
//  HowToPlayViewController.h
//  Mutable
//
//  Created by Dylan Shackelford on 8/12/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "arrowCell.h"
#import "AppUtilities.h"
#import "AppConstants.h"
#import "LevelViewController.h"
#import "SettingsViewController.h"

@interface HowToPlayViewController : UITableViewController
{
    NSArray* tableData;
    NSArray* sectionTitles;
    
    int rowHeight;
}

@property int selectedRow;
@property int selectedSection;
@property int actualSelectedIndex;


@end