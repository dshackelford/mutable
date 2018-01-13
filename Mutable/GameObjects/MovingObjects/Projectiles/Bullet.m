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
        if (wallBool == NO)
        {
            velocity = CGVectorMake(0, 0);
        }
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
    if (wallBool == YES)
    {
        [self moveInCircle];
    }
    else
    {
        [self move];
    }
    if (position.x > (screenWidth + 10) || position.x < -10 || position.y > (screenHeight + 10) || position.y < -10)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }
    
    
    [self detectCollision]; 
}

-(void)detectCollision
{
    for(id object in objectArray)
    {
        //IF OBJECT FOR INTERACTION IS A BULLET OR ITSELF, DON'T WANT TO DO ANYTHING
        if ([[NSString stringWithFormat:@"%@",[object class]] isEqualToString:@"Bullet"] || object == self || [object class] == [HeadLink class])
        {
            
        }
        //IF IT INTERATCTS WITH ANYTHING ELSE, THEN IT'LL 'HIT' ITS TARGET
        else
        {
            if (fabs([object getPosition].x - [self getPosition].x) < [object getSize].width/2 + [self getSize].width/2 && fabs([object getPosition].y - [self getPosition].y) < [object getSize].height/2 + [self getSize].height/2)
            {
                //REMOVE THE BULLET WHEN IT HITS
                [theImage removeFromSuperview];
                
                [objectArray removeObject:self];
                
                //HIT THE OTHER OBJECT THAT THIS BULLET IS HITTING
                [object hit];
                
                //DON'T NEED TO CONTINUE ITERATION
                break;
            }
        }
    }
    
}

-(void)moveInCircle
{
    shapeCounter = shapeCounter + deltaTime;
    
    double lateralPosition = 0;
    double longitudinalPosition = 0;
    
    if (velocity.dx > 0)
    {
        lateralPosition = -shapeRadius*cos(shapeCounter + M_PI_2);
        longitudinalPosition = -shapeRadius*sin(shapeCounter+ M_PI_2);
        
    }
    
    if (velocity.dx < 0)
    {
        lateralPosition = shapeRadius*cos(shapeCounter + M_PI_2);
        longitudinalPosition = shapeRadius*sin(shapeCounter+ M_PI_2);
        
    }
    
//    if(velocity.dy > 0)
//    {
//        lateralPosition = shapeRadius*cos(shapeCounter);
//        longitudinalPosition = shapeRadius*sin(shapeCounter);
//        
//    }
//    
//    if (velocity.dy < 0)
//    {
//        lateralPosition = -shapeRadius*cos(shapeCounter);
//        longitudinalPosition = -shapeRadius*sin(shapeCounter);
//    }
    
    position.x =  shapeCenter.x + lateralPosition;
    position.y =  shapeCenter.y + longitudinalPosition;
    
    theImage.center = position;
}


-(void)crash
{
    
}

-(void)hit
{
    
}

-(void)setWallBool:(BOOL)boolInit
{
    wallBool = boolInit;
}



@end