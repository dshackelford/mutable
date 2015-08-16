//
//  Shifting.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shifting.h"

@implementation Shifting

+(void)shiftMineField:(NSMutableArray*)mineFieldInit
{
    shiftCounter = shiftCounter +1;
    
    if (shiftCounter > 100)
    {
        
        for (int i = 0; i < [mineFieldInit count]; i = i + 3)
        {
            UIImageView* anEnemyImage = [[mineFieldInit objectAtIndex:i] getImage];
            anEnemyImage.hidden = YES;
        }
        
        for (int i = 1; i < [mineFieldInit count]; i = i + 3)
        {
            UIImageView* anEnemyImage = [[mineFieldInit objectAtIndex:i] getImage];
            anEnemyImage.hidden = NO;
        }
    }
    
    if (shiftCounter > 100 && shiftCounter < 200)
    {
        for (int i = 0; i < [mineFieldInit count]; i = i + 3)
        {
            UIImageView* anEnemyImage = [[mineFieldInit objectAtIndex:i] getImage];
            anEnemyImage.hidden = NO;
        }
        
        
        for (int i = 1; i < [mineFieldInit count]; i = i + 3)
        {
            UIImageView* anEnemyImage = [[mineFieldInit objectAtIndex:i] getImage];
            anEnemyImage.hidden = YES;
        }
    }
    
    if (shiftCounter >200)
    {
        shiftCounter = 0;
    }
}

+(void)showMineField:(NSMutableArray*)mineFieldInit
{
    for (Mine* aMine in mineFieldInit)
    {
        [aMine getImage].hidden = NO;
    }
    shiftCounter = 0;
}


@end