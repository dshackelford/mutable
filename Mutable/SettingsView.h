//
//  SettingsView.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "Snake.h"
#import "AppUtilities.h"


@interface SettingsView : UIViewController <UIScrollViewDelegate>
{
    Snake* theSnake;
    
    IBOutlet UIButton* easyButton;
    IBOutlet UIButton* mediumButton;
    IBOutlet UIButton* hardButton;
    IBOutlet UILabel* difficultyLabel;
    
    IBOutlet UIButton* restartButton;
}


-(IBAction)didPressRestartButton:(id)sender;
-(IBAction)didPressEasyButton:(id)sender;
-(IBAction)didPressMediumButton:(id)sender;
-(IBAction)didPressHardButton:(id)sender;


@end