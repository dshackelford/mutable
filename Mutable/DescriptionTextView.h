//
//  DescriptionTextView.h
//  Mutable
//
//  Created by Dylan Shackelford on 8/25/16.
//  Copyright © 2016 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionTextView : UITableViewCell <UITextFieldDelegate>

@property (weak,nonatomic) IBOutlet UILabel* descriptionLabel;


@end