//
//  BlockadeBarricade.m
//  Mutable
//
//  Created by Dylan Shackelford on 12/20/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockadeBarricade.h"


@implementation BlockadeBarricade

+(void)createBlockadeBarricade:(Base*)baseInit View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit
{
    
    double theBarricadeRadius = 50;
    
    if (currentLevel > 9)
    {
        for (int i = 0; i < 4; i = i + 1)
        {
            CGPoint aPosition;
            CGVector aVelocity;
        
            if(i == 0) //bottom
            {
            aPosition = CGPointMake([baseInit getPosition].x, [baseInit getPosition].y + theBarricadeRadius);
                aVelocity = CGVectorMake(-100, 0);
            }
            if(i == 1) //right
            {
                aPosition = CGPointMake([baseInit getPosition].x + theBarricadeRadius, [baseInit getPosition].y);
                aVelocity = CGVectorMake(0, 100);
            }
            if(i == 2) //top
            {
                aPosition = CGPointMake([baseInit getPosition].x, [baseInit getPosition].y - theBarricadeRadius);
                aVelocity = CGVectorMake(100, 0);
            }
            if(i == 3) //left
            {
                aPosition = CGPointMake([baseInit getPosition].x - theBarricadeRadius, [baseInit getPosition].y);
                aVelocity = CGVectorMake(0, -100);
            }
        
            Barracade* aBarracade = [[Barracade alloc] initBlockadeBarricadeElement:baseInit Location:aPosition View:container PlaceHolder:placeHolderButtonInit];
            [aBarracade setVelocity:aVelocity];
        
        }
    }
}


@end