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

-(void)initHeadLink:(CGPoint)positionInit Velocity:(CGVector)velocityInit View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButton
{
    
    position = positionInit;
    
    size = CGSizeMake(10, 10);
    
    velocity = velocityInit;
    
    imageFileName = @"HeadLink";

    [self setImage];
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButton];
    
    bounded = YES;
    
    [dynamicObjectArray addObject:self];
    
}

//THIS METHOD DETERMINES HOW TO MOVE HEADLINK, TAKES SNAKE ARRAY TO DETERMINE THE RAIDUS AND SPEED
-(void)move:(NSMutableArray*)snakeArrayInit
{
    if (shapeShiftBool == NO)
    {
        if (position.y >= screenHeight || position.y <= 0)
        {
            velocity.dy = -velocity.dy;
        }
        
        if (position.x >= screenWidth || position.x <= 0)
        {
            velocity.dx = -velocity.dx;
        }
        
        position.x = position.x + velocity.dx*deltaTime;
        position.y = position.y + velocity.dy*deltaTime;
        
        theImage.center = position;
        
    }
    else
    {
        if (circle == YES)
        {
            shapeRadius = [snakeArrayInit count]/(2*M_PI);
            
            [self moveInCircle];
        }
        
        if (square == YES)
        {
            shapeRadius = [snakeArrayInit count]/4;
            
            if ([snakeArrayInit count] > 0)
            {
                [self moveInSquare];
            }
        }
        
        
        if (triangle == YES)
        {
            shapeRadius = [snakeArrayInit count]/3;
            
            if ([snakeArrayInit count] > 0)
            {
                [self moveInTriangle];
            }
        }
        
        
        if (line == YES)
        {
            shapeRadius = [snakeArrayInit count]/2;
            
            [self moveInLine];
        }
    }
    
}


@end