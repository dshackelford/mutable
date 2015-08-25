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
    
    if ([difficultySetting isEqual:@"Easy"])
    {
         easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    }
    if ([difficultySetting isEqual:@"Medium"])
    {
        mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    }
    if ([difficultySetting isEqual:@"Hard"])
    {
           hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    }
    
}


-(IBAction)didPressRestartButton:(id)sender
{
    NSMutableDictionary* dictionaryFromFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [dictionaryFromFile setObject:@"0" forKey:@"currentLevel"];
    [dictionaryFromFile setObject:@"50" forKey:@"snakeLength"];
    [dictionaryFromFile writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES ];
}


-(IBAction)didPressEasyButton:(id)sender
{
    difficultySetting = @"Easy";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Easy" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}

-(IBAction)didPressMediumButton:(id)sender
{
    difficultySetting = @"Medium";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Medium" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}

-(IBAction)didPressHardButton:(id)sender
{
    difficultySetting = @"Hard";
    
    NSMutableDictionary* myDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    [myDictionary setObject:@"Hard" forKey:@"DifficultySetting"];
    [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES];
    
    easyButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    mediumButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    hardButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
}
@end