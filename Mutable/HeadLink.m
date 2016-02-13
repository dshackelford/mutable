//
//  HeadLink.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeadLink.h"

@implementation HeadLink

-(id)initHeadLink:(CGPoint)positionInit Velocity:(CGVector)velocityInit View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButton
{
    
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(10, 10);
    
    velocity = velocityInit;
    
    imageFileName = @"HeadLink";

    [self setImage];
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButton];
    
    [objectArray addObject:self];
    
    return self;
    
}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    position = positionInit;
    
    size = CGSizeMake(10, 10);
    
    velocity = velocityInit;
    
    imageFileName = @"HeadLink";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}

//THIS METHOD DETERMINES HOW TO MOVE HEADLINK, TAKES SNAKE ARRAY TO DETERMINE THE RAIDUS AND SPEED
-(void)move:(id)objectTracker
{
    if (shapeShiftBool == NO)
    {
        //BOUNCING OFF WALLS
        if (position.y >= screenHeight || position.y <= 0)
        {
            velocity.dy = -velocity.dy;
        }
        
        if (position.x >= screenWidth || position.x <= 0)
        {
            velocity.dx = -velocity.dx;
        }
        
        [self move];
    }
    else
    {
        if (circle == YES)
        {
            shapeRadius = globalSnakeLength/(2*M_PI);
            
            [self moveInCircle];
        }
        
        if (square == YES)
        {
            shapeRadius = globalSnakeLength/4;
            
            if (globalSnakeLength > 0)
            {
                [self moveInSquare];
            }
        }
        
        
        if (triangle == YES)
        {
            shapeRadius = globalSnakeLength/3;
            
            if (globalSnakeLength > 0)
            {
                [self moveInTriangle];
            }
        }
        
        
        if (line == YES)
        {
            shapeRadius = globalSnakeLength/2;
            
            [self moveInLine];
        }
    }
    
    //DETECT COLLISION
    [self detectCollision];
    
}

-(void)detectCollision
{
    //ITERATE THROUGH OBJECTS IN LEVEL
    for (id object in objectArray)
    {
        //IF OBJECT IS HEADLINK OR A BULLET, DO NOT INTERACT WITH IT AT ALL
        if (object == self || [[NSString stringWithFormat:@"%@",[object class]] isEqualToString:@"Bullet"])
        {
            
        }
        else
        {
            if (fabs([object getPosition].x - [self getPosition].x) < [object getSize].width/2 + [self getSize].width/2 && fabs([object getPosition].y - [self getPosition].y) < [object getSize].height/2 + [self getSize].height/2)
            {
                [object crash];
                break;
            }
            
        }
    }
}

-(void)hit
{
    
    
}



@end