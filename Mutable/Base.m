//
//  Base.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base.h"

@implementation Base

-(void)initBase:(HeadLink*)headLinkInit :(double)baseStrengthInit :(UIView*)container :(UIButton*)placeHolderButtonInit locationOverRide:(BOOL)locationOverRide Position:(CGPoint)positionInit
{
    if (locationOverRide == NO)
    {
        position.x = arc4random()%((int)screenWidth - 150) + 150;
        position.y = arc4random()%((int)screenHeight - 150) + 150;
    
        while (fabs([headLinkInit getPosition].y - position.y) < 80 || fabs([headLinkInit getPosition].x - position.x) < 80)
        {
            position.x = arc4random()%((int)screenWidth - 70) + 50;
            position.y = arc4random()%((int)screenHeight - 70) + 50;
        }
    }
    else
    {
        position = positionInit;
    }
    
    
    size = CGSizeMake(45,45);
    
    imageFileName = @"base2";
    
    [self setImage];
    
    //BASE HEALTH IMAGE
    enemyBaseHealth = baseStrengthInit;
    baseHealthCap = enemyBaseHealth;
    
    healthArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < enemyBaseHealth; i = i + 1)
    {
        UIImageView* aHealthImage = [self makeHealthImage];
        
        [container insertSubview:aHealthImage belowSubview:placeHolderButtonInit];
        
        [healthArray addObject:aHealthImage];
        
        aHealthImage.center = CGPointMake(position.x - 10 + 7*i, position.y);
    }
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];

}

-(void)addHealth:(UIView*)container :(UIButton*)placeHolderButtonInit
{
    UIImageView* aHealthImage = [self makeHealthImage];
    
    [container insertSubview:aHealthImage belowSubview:theImage];
    
    enemyBaseHealth = enemyBaseHealth + 1;
    
    UIImageView* lastHealthImage = [healthArray lastObject];
    
    aHealthImage.center  = CGPointMake(lastHealthImage.center.x + 7, lastHealthImage.center.y);
    
    [healthArray addObject:aHealthImage];
     
}




-(UIImageView*)getHealthBarImage
{
    UIImageView* aHealthImage = [[UIImageView alloc] init];
    
    aHealthImage = [healthArray objectAtIndex:0];
    
    return aHealthImage;
}

-(double)getEnemyBaseHealth
{
    return enemyBaseHealth;
}


-(void)hitEnemyBase
{
    //INDEX HAS A MINUS 1 BECUASE HEALTH ARRAY STARTS AT O, NOT 1.
    UIImageView* aHealthImage = [healthArray objectAtIndex:enemyBaseHealth-1];
    
    [aHealthImage removeFromSuperview];
    
    [healthArray removeObjectAtIndex:enemyBaseHealth-1];
    
    enemyBaseHealth = enemyBaseHealth-1;
}

-(double)getBaseHealthCap
{
    return baseHealthCap;
}


-(UIImageView*)makeHealthImage
{
    CGRect healthRect = CGRectMake(100, 150, 7, 27);
    UIImageView* aHealthImage = [[UIImageView alloc]initWithFrame:healthRect];
    aHealthImage.image = [UIImage imageNamed:@"health.png"];
    return aHealthImage;
}

@end