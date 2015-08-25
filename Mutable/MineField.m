//
//  Mine.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineField.h"

@implementation MineField


+(void)makeRandomMineField:(Base *)baseInit headLink:(HeadLink*)headLinkInit container:(UIView *)containerInit placeholder:(UIButton *)placeHolderButton
{
    //MAKE SURE THERE ARE THEIR RIGHT AMOUNT OF MINES ON EVERY LEVEL
    int maximumMines = currentLevel*2;
    int minMines = 1;
    
    if (currentLevel > 6)
    {
        minMines = 6;
        maximumMines = 12;
    }
    else
    {
        minMines = currentLevel;
    }
    
    for( double x = 0; x < 1 + arc4random()%10; x =  x + 1)
    {

        CGPoint minePosition = CGPointMake(arc4random()%((int)screenWidth - 100) + 50, arc4random()%((int)screenHeight - 100) + 50);
        
        
        //CHECK FOR HEADLINK VELOCITY TO SEE HOW TO MOVE MINE OUT OF THE SNAKE INITAL PATH
        if (fabs([headLinkInit getVelocity].dx) > 0)
        {
            
            while ((fabs([baseInit getPosition].y - minePosition.y) < 80 || (fabs([baseInit getPosition].x - minePosition.x) < 80 || fabs([headLinkInit getPosition].y - minePosition.y) < 20) || fabs([headLinkInit getPosition].x - minePosition.x) < 20) )
            {
                minePosition.x = arc4random()%((int)screenWidth - 70) + 70;
                minePosition.y = arc4random()%((int)screenHeight - 70) + 70;
            }
            
            
        }
        if (fabs([headLinkInit getVelocity].dy) > 0)
        {
            if (fabs([headLinkInit getPosition].x - minePosition.x) < 25)
            {
                minePosition = CGPointMake([headLinkInit getPosition].x + 25, minePosition.y);
            }
        }
        
        //ADD THE MINE TO THE ARRAY TO BE RETURNED TO THE LEVEL CONTROLLER
        Mine* aMine = [[Mine alloc] initMine:minePosition :containerInit :placeHolderButton];
    }
}


+(void)makeBaseBarracade:(Base *)baseInit container:(UIView*)containerInit placeHolder:(UIButton*)placeHolderButton
{
    NSMutableArray* arrayOfPositions = [[NSMutableArray alloc] init];
    
    int numberOfMines = 5;
    
    //ADDING MINES IN A SQUARE FASHION AROUND THE LOACTION OF THE BASE
    for (int i = 0; i < numberOfMines ; i = i + 1)
    {

        
        CGPoint somePoint = CGPointMake([baseInit getPosition].x + 40 - 15*i ,[baseInit getPosition].y + 40);
        
        [arrayOfPositions addObject:[NSValue valueWithCGPoint:somePoint]];
        
    }
    for (int i = 0; i < numberOfMines + 1; i = i + 1)
    {

        
        CGPoint somePoint = CGPointMake([baseInit getPosition].x + 40 - 15*i ,[baseInit getPosition].y - 40);
        
        [arrayOfPositions addObject:[NSValue valueWithCGPoint:somePoint]];
        
    }
    for (int i = 0; i < numberOfMines ; i = i + 1)
    {

        
        CGPoint somePoint = CGPointMake([baseInit getPosition].x - 40 ,[baseInit getPosition].y + 40 - 15*i);
        
        [arrayOfPositions addObject:[NSValue valueWithCGPoint:somePoint]];
    }
    for (int i = 0; i < numberOfMines ; i = i + 1)
    {
        
        CGPoint somePoint = CGPointMake([baseInit getPosition].x + 40 ,[baseInit getPosition].y + 40 - 15*i);
        
        [arrayOfPositions addObject:[NSValue valueWithCGPoint:somePoint]];
    }
    
    
    
    for (int a = 0; a < [arrayOfPositions count]; a = a + 1)
    {
        Mine* aMine = [[Mine alloc] initMine: [[arrayOfPositions objectAtIndex:a] CGPointValue] :containerInit :placeHolderButton];
    }
    
}


@end