//
//  HomeView.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "AppUtilities.h"
#import <QuartzCore/QuartzCore.h>
#import "Snake.h"
#import "HeadLink.h"

@interface HomeView : UIViewController
{
    UIImageView* circleView;
    
    IBOutlet UIButton* mutableTitle;
    
    IBOutlet UIButton* playButton;
    IBOutlet UIButton* settingsButton;
    IBOutlet UIButton* howToPlayButton;
    
    
    IBOutlet UIButton* homeViewPlaceHolderButton;
    
}


@end