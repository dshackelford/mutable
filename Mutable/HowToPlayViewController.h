//
//  HowToPlayViewController.h
//  Mutable
//
//  Created by Dylan Shackelford on 8/12/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUtilities.h"
#import "AppConstants.h"
#import "LevelViewController.h"
#import "SettingsViewController.h"

#import "arrowCell.h"
#import "HeaderCell.h"
#import "DescriptionView.h"
#import "DescriptionTextView.h"

@interface HowToPlayViewController : UITableViewController
{
    NSArray* tableData;
    NSArray* sectionTitles;
    NSArray* imageFileNames;
    NSArray* descriptions;
    int rowHeight;
    CGSize screenSize;
}

@property int selectedRow;
@property int selectedSection;
@property int actualSelectedIndex;


@end