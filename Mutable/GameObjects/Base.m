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

-(id)initBase:(HeadLink*)headLinkInit :(double)baseStrengthInit :(UIView*)container :(UIButton*)placeHolderButtonInit locationOverRide:(BOOL)locationOverRide Position:(CGPoint)positionInit
{
    self = [super init];
    
    if (locationOverRide == NO)
    {
        position.x = arc4random()%((int)screenWidth - 150) + 90;
        position.y = arc4random()%((int)screenHeight - 150) + 90;
    
        while (fabs([headLinkInit getPosition].y - position.y) < 80 || fabs([headLinkInit getPosition].x - position.x) < 80)
        {
            position.x = arc4random()%((int)screenWidth - 150) + 90;
            position.y = arc4random()%((int)screenHeight - 150) + 90;
        }
    }
    else
    {
        position = positionInit;
    }
    
    if (currentLevel > 6)
    {
        regneration = YES;
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
    
    [objectArray addObject:self];
    
    return self;

}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    position = positionInit;
    
    size = CGSizeMake(45, 45);
    
    imageFileName = @"base2";
    
    [self setImage];
    
    enemyBaseHealth = 5;
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
    
    [objectArray addObject:self];
    
    return self;
}

#pragma mark - Interactions

-(void)hit
{
    //INDEX HAS A MINUS 1 BECUASE HEALTH ARRAY STARTS AT O, NOT 1.
    UIImageView* aHealthImage = [healthArray objectAtIndex:enemyBaseHealth-1];
    
    [aHealthImage removeFromSuperview];
    
    [healthArray removeObjectAtIndex:enemyBaseHealth-1];
    
    enemyBaseHealth = enemyBaseHealth-1;
    
    if (enemyBaseHealth == 0)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }
}






//REGENERATION
-(void)addHealth:(UIView*)container :(UIButton*)placeHolderButtonInit
{
    if (regneration == YES && enemyBaseHealth > 0)
    {
        UIImageView* aHealthImage = [self makeHealthImage];
    
        [container insertSubview:aHealthImage belowSubview:theImage];
    
        enemyBaseHealth = enemyBaseHealth + 1;
    
        UIImageView* lastHealthImage = [healthArray lastObject];
    
        aHealthImage.center  = CGPointMake(lastHealthImage.center.x + 7, lastHealthImage.center.y);
    
        [healthArray addObject:aHealthImage];
    }
    
}



#pragma mark - Getters

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


-(double)getBaseHealthCap
{
    return baseHealthCap;
}

-(BOOL)getRegeneration
{
    return regneration;
}

#pragma mark - Health Image

-(UIImageView*)makeHealthImage
{
    CGRect healthRect = CGRectMake(100, 150, 7, 27);
    UIImageView* aHealthImage = [[UIImageView alloc]initWithFrame:healthRect];
    aHealthImage.image = [UIImage imageNamed:@"health.png"];
    return aHealthImage;
}

@end