//
//  SubSettingsViewController.h
//  Mutable
//
//  Created by Dylan Shackelford on 8/23/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "arrowCell.h"

@interface SubSettingsViewController : UITableViewController
{
    NSArray* tableData;
    CGSize screenSize;
}

-(void)setTableData:(NSArray*)dataArrayInit;

-(void)setTitle:(NSString *)titleInit;

@end