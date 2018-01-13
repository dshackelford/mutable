
//
//  TurretGun.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/8/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TurretGun.h"


@implementation TurretGun

#pragma mark - Inits
-(id)initTurretGun:(HeadLink*)theHeadLink Base:(Base*)baseInit LocationOverRide:(BOOL)locationOverRide Position:(CGPoint)positionInit Velocity:(CGVector)velocityInit View:(UIView *)viewInit PlaceHolder:(UIButton *)placeHolderButton
{
    self = [super init];
    
    size = CGSizeMake(45, 45);
    
    imageFileName = @"TurretGun";
    
    if (locationOverRide == NO)
    {
        position.x = arc4random()%((int)screenWidth - 70) + 50;
        position.y = arc4random()%((int)screenHeight - 70) + 50;
        
        while (fabs([theHeadLink getPosition].y - position.y) < size.height/2 + [theHeadLink getSize].height/2 || fabs([theHeadLink getPosition].x - position.x) < size.width/2 + [theHeadLink getSize].width/2 || fabs([baseInit getPosition].x - position.x) < size.width/2 + [baseInit getSize].width/2 || fabs([baseInit getPosition].y - position.y) < size.height/2 + [baseInit getSize].height/2 )
        {
            position.x = arc4random()%((int)screenWidth - 70) + 50;
            position.y = arc4random()%((int)screenHeight - 70) + 50;
            
        }
    }
    else
    {
        position = positionInit;
    }

    velocity = velocityInit;
    
    [self setImage];
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButton];
    
    //BASE HEALTH IMAGE
    turretHealth = 5;
    
    turretHealthArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < turretHealth; i = i + 1)
    {
        UIImageView* aHealthImage = [self makeHealthImage];
        
        [viewInit insertSubview:aHealthImage belowSubview:placeHolderButton];
        
        [turretHealthArray addObject:aHealthImage];
        
        aHealthImage.center = CGPointMake(position.x - 14 + 7*i, position.y);
    }
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButton];
    
    [objectArray addObject:self];
    
    return self;

}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(45, 45);
    
    imageFileName = @"TurretGun";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    //BASE HEALTH IMAGE
    turretHealth = 5;
    
    turretHealthArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < turretHealth; i = i + 1)
    {
        UIImageView* aHealthImage = [self makeHealthImage];
        
        [container insertSubview:aHealthImage belowSubview:placeHolderButtonInit];
        
        [turretHealthArray addObject:aHealthImage];
        
        aHealthImage.center = CGPointMake(position.x - 14 + 7*i, position.y);
    }
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;

}

#pragma mark - Interactions
-(void)move
{
    position.x = position.x + velocity.dx*deltaTime;
    position.y = position.y + velocity.dy*deltaTime;
        
    if (position.x > screenWidth)
    {
        velocity.dx = -velocity.dx;
        position.x = screenWidth;
    }
    if (position.x < 0)
    {
        velocity.dx = -velocity.dx;
        position.x = 0;
    }
    
    if (position.y > screenHeight)
    {
        velocity.dy = -velocity.dy;
        position.y = screenHeight;
    }
    if (position.y < 0)
    {
        velocity.dy = -velocity.dy;
        position.y = 0;
    }
        
    theImage.center = position;
    
}

-(void)hit
{
    //INDEX HAS A MINUS 1 BECUASE HEALTH ARRAY STARTS AT O, NOT 1.
    UIImageView* aHealthImage = [turretHealthArray objectAtIndex:turretHealth-1];
    
    [aHealthImage removeFromSuperview];
    
    [turretHealthArray removeObjectAtIndex:turretHealth-1];
    
    turretHealth = turretHealth - 1;
    
    if (turretHealth == 0)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }
}


#pragma mark - Getters

-(UIImageView*)getHealthBarImage
{
    UIImageView* aHealthImage = [[UIImageView alloc] init];
    
    aHealthImage = [turretHealthArray objectAtIndex:0];
    
    return aHealthImage;
}

-(double)getTurretHealth
{
    return turretHealth;
}


-(BOOL)getTurretMovingBoolean
{
    return moving;
}


-(UIImageView*)makeHealthImage
{
    CGRect healthRect = CGRectMake(100, 150, 7, 25);
    UIImageView* aHealthImage = [[UIImageView alloc]initWithFrame:healthRect];
    aHealthImage.image = [UIImage imageNamed:@"health.png"];
    return aHealthImage;
}

@end