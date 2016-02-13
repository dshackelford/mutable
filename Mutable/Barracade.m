//
//  Barracade.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Barracade.h"



@implementation Barracade

-(id)initBlockadeBarricadeElement:(Base*)baseInit Location:(CGPoint)locationInit View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit
{
    self = [super init];
    
    barricadeRadius = 50;
    
    size = CGSizeMake(23, 23);
    
    position = locationInit;
    
    imageFileName = @"blockadeElement";
    
    shapeCenter = [baseInit getPosition];
    
    shapeRadius = 50;
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}



-(void)move:(id)tracker
{
    [self moveInSquare];
}

-(void)moveInSquare
{
    shapeCounter = shapeCounter + deltaTime;
    
    
    CGPoint topRight = CGPointMake(shapeCenter.x + shapeRadius,shapeCenter.y - shapeRadius);
    CGPoint topLeft = CGPointMake(shapeCenter.x - shapeRadius, shapeCenter.y - shapeRadius);
    CGPoint bottomRight = CGPointMake(shapeCenter.x + shapeRadius, shapeCenter.y + shapeRadius);
    CGPoint bottomLeft = CGPointMake(shapeCenter.x - shapeRadius, shapeCenter.y + shapeRadius);
    
    //turn down at top right corner
    if (position.x > topRight.x && position.y < shapeCenter.y)
    {
        velocity.dx = 0;
        velocity.dy = snakeVelocity/3;
    }
    
    //Go left at bottom right corner
    if (position.x > shapeCenter.x && position.y > bottomRight.y)
    {
        velocity.dx = -snakeVelocity/3;
        velocity.dy = 0;
    }
    
    
    //turn up at bottom left corner
    if (position.x < bottomLeft.x && position.y > shapeCenter.y)
    {
        velocity.dx = 0;
        velocity.dy = -snakeVelocity/3;
    }
    
    
    //turn right at top left corner
    if (position.y < topLeft.y  && position.x < shapeCenter.x)
    {
        velocity.dx = snakeVelocity/3;
        velocity.dy = 0;
    }
    
    [self move];
}


-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(23,23);
    
    shapeRadius = 50;
    
    imageFileName = @"blockadeElement";
    
    shapeCenter = [[objectArray objectAtIndex:0] getPosition];
    
    velocity = velocityInit;
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}


@end