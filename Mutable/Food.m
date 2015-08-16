//
//  Food.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/29/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"


@implementation Food

-(void)initFood:(Base*)enemyBase View:(UIView *)container placeHolder:(UIButton *)placeHolderButton
{
    
    position.x = arc4random()%((int)screenWidth - 100) + 50;
    position.y = arc4random()%((int)screenHeight - 100) + 50;
    
    if (fabs(position.x - [enemyBase getLatitude]) < 50)
    {
        if ([enemyBase getPosition].x > screenWidth/2)
        {
            position.x = [enemyBase getPosition].x - 50;
        }
        
        if ([enemyBase getPosition].x <= screenWidth/2)
        {
            position.x = [enemyBase getPosition].x + 50;
        }
    }
    if (fabs(position.y - [enemyBase getPosition].y) < 50)
    {
        if ([enemyBase getPosition].x > screenHeight/2)
        {
            position.y = [enemyBase getPosition].y - 50;
        }
        
        if ([enemyBase getLatitude] <= screenHeight/2)
        {
            position.y = [enemyBase getPosition].y + 50;
        }
    }
    
    size = CGSizeMake(25, 25);
    
    imageFileName = @"lifePowerUp";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButton];
    
//    [staticObjectArray addObject:self];
}

@end