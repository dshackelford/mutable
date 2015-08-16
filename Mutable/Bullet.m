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

-(void)initBullet:(CGPoint)targetInit InitialPosition:(CGPoint)initialPosition Container:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit
{
    
    if (shapeShiftBool == YES)
    {
        position = initialPosition;
    }
    
    imageFileName = @"Point";
    
    [self setImage];
    
    dx = targetInit.x - position.x;
    dy = targetInit.y - position.y;
    
    //bulletSpeed = 900;
    bulletSpeed = 9000/size.width;
    
    bulletTime = sqrt(dx*dx+dy*dy)/bulletSpeed;
    
    Vx = dx/bulletTime;
    Vy = dy/bulletTime;
    
    velocity = CGVectorMake(Vx, Vy);
    
    [container insertSubview: theImage belowSubview:placeHolderButtonInit];
    
    [dynamicObjectArray addObject:self];
}



@end