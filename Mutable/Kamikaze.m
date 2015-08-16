//
//  Kamikaze.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kamikaze.h"

@implementation Kamikaze

-(void)initKamikaze:(CGPoint)targetInit Container:(UIView*)viewInit PlaceHolderButton:(UIButton*)placeHolderButton
{
    int locationDeterminant = arc4random()%100;
    
    //GO FROM BOTTOM
    if(locationDeterminant < 25)
    {
        position.x = arc4random()%(int)screenWidth;
        position.y = screenHeight + 5;
    }
    //GO FROM LEFTSIDE
    else if(locationDeterminant > 25 && locationDeterminant < 50)
    {
        position.x = -5;
        position.y = arc4random()%(int)screenHeight;

    }
    //GO FROM TOP
    else if(locationDeterminant > 50 && locationDeterminant < 75)
    {
        position.x = arc4random()%(int)screenWidth;
        position.y = -5;

    }
    //GO FROM RIGHTSIDE
    else
    {
        position.x = screenWidth + 5;
        position.y = arc4random()%(int)screenHeight;
    }

    size = CGSizeMake(25, 40);
    
    imageFileName = @"newKamikaze";
    
    [self setImage];
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButton];
    
    double dx = targetInit.x - position.x;
    double dy = targetInit.y - position.y;
    
    double hypotenuse = sqrt(dx*dx + dy*dy);
    
    double kamikazeSpeed = 300;
    
    double kamikazeTime = hypotenuse/kamikazeSpeed;
    
    double vx = dx/kamikazeTime;
    double vy = dy/kamikazeTime;
    
    velocity = CGVectorMake(vx, vy);
    
    
    //ROTATE IMAGE FOR ASETHETIC PURPOSES
    if (dy > 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse)+3.14;
    }
    if (dy > 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + 3.14;
    }
    
    if (dy < 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse) + 3.14;
    }
    
    if (dy < 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + 3.14;
    }
    
    theImage.transform = CGAffineTransformMakeRotation(angleOfRotation);
    
    
    [dynamicObjectArray addObject:self];
}

-(void)kamikazeMovement:(CGPoint)targetInit :(NSMutableArray*)kamikazeArrayInit;
{
    [self moveKamikaze: targetInit];
    
    theImage.center = position;
     
     if (position.x > (screenWidth + 5) || position.x < -5)
     {
         [kamikazeArrayInit removeObject:self];
         [theImage removeFromSuperview];
     }
     
     if (position.y > (screenHeight + 5) || position.y < 5)
     {
         [kamikazeArrayInit removeObject:self];
         [theImage removeFromSuperview];
     }

}

-(void)moveKamikaze:(CGPoint)targetInit
{
    double xDesitination = targetInit.x;
    double yDesitination = targetInit.y;
    
    double dx = xDesitination - position.x;
    double dy = yDesitination - position.y;
    
    double hypotenuse = sqrt(dx*dx + dy*dy);
    
    double kamikaziVelocity = 145;
    
    double kamikaziTime = hypotenuse/kamikaziVelocity;
    
    double vx = dx/kamikaziTime;
    double vy = dy/kamikaziTime;
    
    //ROTATE IMAGE FOR ASETHETIC PURPOSES
    if (dy > 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse)+3.14;
    }
    if (dy > 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + 3.14;
    }
    
    if (dy < 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse) + 3.14;
    }
    
    if (dy < 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + 3.14;
    }
    
    velocity = CGVectorMake(vx, vy);
    
    [self getImage].transform = CGAffineTransformMakeRotation(angleOfRotation);
    
    position.x = position.x + velocity.dx*deltaTime;
    position.y = position.y + velocity.dy*deltaTime;

}

@end