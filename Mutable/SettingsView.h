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
#import "AppFile.h"


@interface SettingsView : UIViewController <UIScrollViewDelegate>
{
    Snake* theSnake;
    
    IBOutlet UIButton* circleButton;
    IBOutlet UIButton* squareButton;
    IBOutlet UIButton* lineButton;
    IBOutlet UIButton* restartButton;
    
    IBOutlet UISlider* snakeLengthSlider;
    IBOutlet UILabel* sliderLabel;
    
}

-(IBAction)didPressCircleButton:(id)sender;
-(IBAction)didPressSquareButton:(id)sender;
-(IBAction)didPressLineButton:(id)sender;
-(IBAction)didSlideSnakeLengthSlider:(id)sender;
-(IBAction)didPressRestartButton:(id)sender;

@end