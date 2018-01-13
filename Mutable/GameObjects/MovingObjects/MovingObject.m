//
//  MovingObject.m
//  Mutable
//
//  Created by Dylan Shackelford on 3/19/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovingObject.h"

@implementation MovingObject

-(id)initMovingObject:(CGPoint)positionInit :(CGVector)velocityInit :(CGSize)sizeInit :(NSString*)imageFileString
{
    self = [super init];
    
    velocity = velocityInit;
    
    size = sizeInit;
    
    position = positionInit;
    
    imageFileName = imageFileString;
    
    [self setImage];
    
    return self;
    
}

-(void)move
{
    position.x = position.x + velocity.dx*deltaTime;
    position.y = position.y + velocity.dy*deltaTime;
    
    theImage.center = position;
}


//MOVER METHODS FOR ALL MOVING OBJECTS
-(void)move:(id)objectTracker
{
    position.x = position.x + velocity.dx*deltaTime;
    position.y = position.y + velocity.dy*deltaTime;
    
    theImage.center = position;
}

-(void)moveInCircle
{
    shapeCounter = shapeCounter + deltaTime;

    double lateralPosition = 0;
    double longitudinalPosition = 0;
    
    if (velocity.dx > 0)
    {
        lateralPosition = -shapeRadius*cos(shapeCounter*snakeVelocity/10 + M_PI_2);
        longitudinalPosition = -shapeRadius*sin(shapeCounter*snakeVelocity/10+ M_PI_2);
        
    }
    
    if (velocity.dx < 0)
    {
        lateralPosition = shapeRadius*cos(shapeCounter*snakeVelocity/10 + M_PI_2);
        longitudinalPosition = shapeRadius*sin(shapeCounter*snakeVelocity/10+ M_PI_2);
    
    }
    
    if(velocity.dy > 0)
    {
        lateralPosition = shapeRadius*cos(shapeCounter*snakeVelocity/10);
        longitudinalPosition = shapeRadius*sin(shapeCounter*snakeVelocity/10);
        
    }
    
    if (velocity.dy < 0)
    {
        lateralPosition = -shapeRadius*cos(shapeCounter*snakeVelocity/10);
        longitudinalPosition = -shapeRadius*sin(shapeCounter*snakeVelocity/10);
    }
    
    position.x =  shapeCenter.x + lateralPosition;
    position.y =  shapeCenter.y + longitudinalPosition;
    
    theImage.center = position;
}

-(void)moveInLine
{
    shapeCounter = shapeCounter + deltaTime;
    
    //DETERMINE SHAPE SHIFT CENTER FOR BULLETS
    if (shapeCounter <= deltaTime)
    {
        double centerX = 0;
        double centerY = 0;
        
        if (velocity.dx > 0)
        {
            centerX = position.x - shapeRadius;
            centerY = position.y;
        }
        if (velocity.dx < 0)
        {
            centerX = position.x + shapeRadius;
            centerY = position.y;
        }
        if (velocity.dy > 0)
        {
            centerX = position.x;
            centerY = position.y - shapeRadius;
        }
        if (velocity.dy < 0)
        {
            centerX = position.x;
            centerY = position.y + shapeRadius;
        }
        
        shapeCenter = position;
    }
    
        if (velocity.dx > 0)
        {
            double lateralPosition = -shapeRadius*cos(shapeCounter*snakeVelocity/10 + M_PI_2);
            
            position.x =  shapeCenter.x + lateralPosition;
        }
        
        if (velocity.dx < 0)
        {
            double lateralPosition = shapeRadius*cos(shapeCounter*snakeVelocity/10 + M_PI_2);
            
            position.x =  shapeCenter.x + lateralPosition;
        }
        
        if(velocity.dy > 0)
        {
            double longitudinalPosition = shapeRadius*sin(shapeCounter*snakeVelocity/10);
            
            position.y =  shapeCenter.y + longitudinalPosition;
        }
        
        if (velocity.dy < 0)
        {
            double longitudinalPosition = -shapeRadius*sin(shapeCounter*snakeVelocity/10);
            
            position.y =  shapeCenter.y + longitudinalPosition;
        }

    
    theImage.center = position;
}


-(void)moveInSquare
{
    shapeCounter = shapeCounter + deltaTime;
    
    if (shapeCounter <= deltaTime)
    {
        double centerX = 0;
        double centerY = 0;
        
        if (velocity.dx > 0)
        {
            centerX = position.x;
            centerY = position.y + shapeRadius/2;
        }
        else if(velocity.dx < 0)
        {
            centerX = position.x;
            centerY = position.y - shapeRadius/2;
        }
        else if (velocity.dy > 0)
        {
            centerX = position.x - shapeRadius/2;
            centerY = position.y - shapeRadius/2;
        }
        else
        {
            centerX = position.x + shapeRadius/2;
            centerY = position.y + shapeRadius/2;
        }
        
        shapeCenter = CGPointMake(centerX, centerY);
    }
    
    
    
    CGPoint topRight = CGPointMake(shapeCenter.x + shapeRadius/2,shapeCenter.y - shapeRadius/2);
    CGPoint topLeft = CGPointMake(shapeCenter.x - shapeRadius/2, shapeCenter.y - shapeRadius/2);
    CGPoint bottomRight = CGPointMake(shapeCenter.x + shapeRadius/2, shapeCenter.y + shapeRadius/2);
    CGPoint bottomLeft = CGPointMake(shapeCenter.x - shapeRadius/2, shapeCenter.y + shapeRadius/2);
    
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


-(void)moveInTriangle
{
    shapeCounter = shapeCounter + deltaTime;
    
    CGPoint ACorner;
    CGPoint BCorner;
    CGPoint CCorner;
    
    if (shapeCounter <= deltaTime)
    {
        double centerX = 0;
        double centerY = 0;
        
        if (velocity.dx > 0)
        {
            centerX = position.x - shapeRadius/2;
            centerY = position.y + sqrt(3*shapeRadius*shapeRadius/4)/2;
            
            shapeCenter = CGPointMake(centerX, centerY);
            
            boundraryCondition = 1;
            
            ACorner = position;
            BCorner = CGPointMake(shapeCenter.x , position.y + sqrt(3*shapeRadius*shapeRadius/4));
            CCorner = CGPointMake(position.x - shapeRadius, position.y);
            
            
        }
        else if(velocity.dx < 0)
        {
            centerX = position.x + shapeRadius/2;
            centerY = position.y - sqrt(3*shapeRadius*shapeRadius/4)/2;
            
            boundraryCondition = 2;

        }
        else if (velocity.dy > 0)
        {
            centerX = position.x - sqrt(3*shapeRadius*shapeRadius/4)/2;
            centerY = position.y - shapeRadius/2;
            
            boundraryCondition = 3;

        }
        else
        {
            centerX = position.x + shapeRadius/2;
            centerY = position.y + sqrt(3*shapeRadius*shapeRadius/4)/2;
            
            boundraryCondition = 4;

        }
        
        shapeCenter = CGPointMake(centerX, centerY);
    }
    
    switch (boundraryCondition)
    {
        case 1:
            ACorner = CGPointMake(shapeCenter.x + shapeRadius/2, shapeCenter.y - sqrt(3*shapeRadius*shapeRadius/4)/2);
            BCorner = CGPointMake(shapeCenter.x, shapeCenter.y + sqrt(3*shapeRadius*shapeRadius/4)/2);
            CCorner = CGPointMake(shapeCenter.x - shapeRadius/2, shapeCenter.y - sqrt(3*shapeRadius*shapeRadius/4)/2 );
            
            if (position.x > ACorner.x && position.y < shapeCenter.y)//turn downleft
            {
                velocity.dx = -snakeVelocity/3;
                velocity.dy = snakeVelocity/3;
            }
            else if(position.x < BCorner.x && position.y > shapeCenter.y)
            {
                velocity.dx = -snakeVelocity/3;
                velocity.dy = -snakeVelocity/3;
            }
            else if(position.x < CCorner.x && position.y < shapeCenter.y)
            {
                velocity.dx = snakeVelocity/3;
                velocity.dy = 0;
            }
            
            break;
            
        case 2:
            ACorner = CGPointMake(shapeCenter.x - shapeRadius/2, shapeCenter.y + sqrt(3*shapeRadius*shapeRadius/4)/2);
            BCorner = CGPointMake(shapeCenter.x, shapeCenter.y - sqrt(3*shapeRadius*shapeRadius/4)/2);
            CCorner = CGPointMake(shapeCenter.x + shapeRadius/2, shapeCenter.y + sqrt(3*shapeRadius*shapeRadius/4)/2 );
            
            if (position.x < ACorner.x && position.y > shapeCenter.y)//turn downleft
            {
                velocity.dx = snakeVelocity/3;
                velocity.dy = -snakeVelocity/3;
            }
            else if(position.x > BCorner.x && position.y < shapeCenter.y)
            {
                velocity.dx = snakeVelocity/3;
                velocity.dy = snakeVelocity/3;
            }
            else if(position.x > CCorner.x && position.y > shapeCenter.y)
            {
                velocity.dx = -snakeVelocity/3;
                velocity.dy = 0;
            }
            break;
            
        case 3:
            ACorner = CGPointMake(shapeCenter.x + sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y + shapeRadius/2);
            BCorner = CGPointMake(shapeCenter.x - sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y);
            CCorner = CGPointMake(shapeCenter.x + sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y - shapeRadius/2);
            
            if (position.x > shapeCenter.x && position.y > ACorner.y)//turn downleft
            {
                velocity.dx = -snakeVelocity/3;
                velocity.dy = -snakeVelocity/3;
            }
            else if(position.x < shapeCenter.x && position.y < BCorner.y)
            {
                velocity.dx = snakeVelocity/3;
                velocity.dy = -snakeVelocity/3;
            }
            else if(position.x > CCorner.x && position.y < shapeCenter.y)
            {
                velocity.dx = 0;
                velocity.dy = snakeVelocity/3;
            }
            break;
            
        case 4:
            ACorner = CGPointMake(shapeCenter.x - sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y - shapeRadius/2);
            BCorner = CGPointMake(shapeCenter.x + sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y);
            CCorner = CGPointMake(shapeCenter.x - sqrt(3*shapeRadius*shapeRadius/4)/2, shapeCenter.y + shapeRadius/2);
            
            if (position.x < shapeCenter.x && position.y < ACorner.y)//turn downleft
            {
                velocity.dx = snakeVelocity/3;
                velocity.dy = snakeVelocity/3;
            }
            else if(position.x > shapeCenter.x && position.y > BCorner.y)
            {
                velocity.dx = -snakeVelocity/3;
                velocity.dy = snakeVelocity/3;
            }
            else if(position.x < CCorner.x && position.y > shapeCenter.y)
            {
                velocity.dx = 0;
                velocity.dy = -snakeVelocity/3;
            }
            break;
            
        default:
            break;
    }
    
    
    position.x = position.x + velocity.dx*deltaTime;
    position.y = position.y + velocity.dy*deltaTime;
    
    theImage.center = position;
    
}


//-(CGVector)getVelocity
//{
//    return velocity;
//}

-(CGPoint)getShapeCenter
{
    return shapeCenter;
}

-(double)getShapeRadius
{
    return shapeRadius;
}

-(void)resetShapeCounter
{
    shapeCounter = 0;
}


-(void)setVelocity:(CGVector)velocityVectorInit
{
    velocity = velocityVectorInit;
}

-(void)setShapeCenter:(CGPoint)shapeCenterInit
{
    shapeCenter = shapeCenterInit;
}

-(void)setShapeRadius:(double)shapeRadiusInit
{
    shapeRadius = shapeRadiusInit;
}




@end