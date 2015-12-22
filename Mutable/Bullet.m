//
//  Bullet.m
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

@implementation Bullet

-(id)initBullet:(CGPoint)targetInit InitialPosition:(CGPoint)initialPosition Size:(CGSize)sizeInit Container:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit
{
    self = [super init];
    
    if (shapeShiftBool == YES)
    {
        position = initialPosition;
    }
    
    imageFileName = @"Point";
    
    size = sizeInit;
    
    [self setImage];
    
    dx = targetInit.x - position.x;
    dy = targetInit.y - position.y;
    
    //bulletSpeed = 900;
    bulletSpeed = 9000/size.width;
    
    bulletTime = sqrt(dx*dx+dy*dy)/bulletSpeed;
    
    Vx = dx/bulletTime;
    Vy = dy/bulletTime;
    
    if (dx == 0 && dy == 0)
    {
        velocity = CGVectorMake(0, 0);
    }
    else
    {
        velocity = CGVectorMake(Vx, Vy);
    }
    
    [container insertSubview: theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}

-(void)move:(id)objectTracker
{
    [self move];
    
    if (position.x > (screenWidth + 10) || position.x < -10 || position.y > (screenHeight + 10) || position.y < -10)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }
    
    
    [self detectCollision]; 
}

-(void)detectCollision
{
    for (int i = 0; i < [objectArray count]; i = i + 1)
    {
        id object = [objectArray objectAtIndex:i];
        
        if(object != self)
        {
            if (fabs([object getPosition].x - [self getPosition].x) < [object getSize].width/2 + [self getSize].width/2 && fabs([object getPosition].y - [self getPosition].y) < [object getSize].height/2 + [self getSize].height/2)
            {

                [theImage removeFromSuperview];
                    
                [objectArray removeObject:self];
                    
                [object hit];
                
                break;
            }
        }
    }
}

-(void)crash
{
    
}

-(void)hit
{
    
}



@end