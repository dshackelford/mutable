//
//  HeaderCell.h
//  Mutable
//
//  Created by Dylan Shackelford on 8/24/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCell : UITableViewCell <UITextFieldDelegate>

@property (weak,nonatomic) IBOutlet UILabel* mainLabel;

-(UILabel*)getCellLabel;

@end