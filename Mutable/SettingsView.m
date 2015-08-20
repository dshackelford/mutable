//
//  SettingsView.m
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsView.h"

@implementation SettingsView

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    if (globalSnakeLength == 0)
    {
        globalSnakeLength = 100;
        [snakeLengthSlider setValue:globalSnakeLength];
    }
    else
    {
        theSnake = [[Snake alloc] init];
        //globalSnakeLength = [theSnake getSnakeLength];
        [snakeLengthSlider setValue:globalSnakeLength];
    }
    
    sliderLabel.text = [NSString stringWithFormat:@"%.f",[snakeLengthSlider value]];
}

-(void)didSlideSnakeLengthSlider:(id)sender
{
    float someValue = [snakeLengthSlider value];
    sliderLabel.text = [NSString stringWithFormat:@"%.f",someValue];
    //Snake* theSnake = [[Snake alloc] init];
    [theSnake setSnakeLength:[snakeLengthSlider value]];
    globalSnakeLength = [snakeLengthSlider value];
    
}

-(void)didPressCircleButton:(id)sender
{
    circle = YES;
    square = NO;
    line = NO;
}

-(void)didPressSquareButton:(id)sender
{
    square = YES;
    circle = NO;
    line = NO;
}

-(void)didPressLineButton:(id)sender
{
    line = YES;
    square = NO;
    circle = NO;
}
-(IBAction)didPressRestartButton:(id)sender
{
    NSMutableDictionary* dictionaryFromFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppFile getPathToUserInfoFile]];
    [dictionaryFromFile setObject:@"0" forKey:@"currentLevel"];
    [dictionaryFromFile setObject:@"50" forKey:@"snakeLength"];
    [dictionaryFromFile writeToFile:[AppFile getPathToUserInfoFile] atomically:YES ];
}

@end