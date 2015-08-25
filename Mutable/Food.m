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

-(id)initFood:(Base*)enemyBase View:(UIView *)container placeHolder:(UIButton *)placeHolderButton
{
    character = @"PowerUp";
    
    self = [super init];
    
    position.x = arc4random()%((int)screenWidth - 100) + 50;
    position.y = arc4random()%((int)screenHeight - 100) + 50;
    
    if (fabs(position.x - [enemyBase getPosition].x) < 50)
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
        
        if ([enemyBase getPosition].x <= screenHeight/2)
        {
            position.y = [enemyBase getPosition].y + 50;
        }
    }
    
    size = CGSizeMake(25, 25);
    
    imageFileName = @"lifePowerUp";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButton];
    
    [objectArray addObject:self];
    
    return self;
}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(25, 25);
    
    imageFileName = @"lifePowerUp";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}


-(void)crash
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddLinks" object:self];
    [objectArray removeObject:self];
    [theImage removeFromSuperview];
}

-(void)hit
{
    
}

@end