//
//  Kamikaze.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drone.h"

@implementation Drone

-(id)initDrone:(CGPoint)targetInit Container:(UIView*)viewInit PlaceHolderButton:(UIButton*)placeHolderButton
{
    self = [super init];
    
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
    
    double droneSpeed = 300;
    
    double droneTime = hypotenuse/droneSpeed;
    
    double vx = dx/droneTime;
    double vy = dy/droneTime;
    
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
    
    [objectArray addObject:self];
    
    return self;
}

-(void)move:(id)objectTracker
{
    [self moveDrone: [objectTracker getPosition]];
    
    theImage.center = position;
     
     if (position.x > (screenWidth + 5) || position.x < -5)
     {
         [theImage removeFromSuperview];
     }
     
     if (position.y > (screenHeight + 5) || position.y < 5)
     {
        [theImage removeFromSuperview];
     }
    
   // [self detectCollision];

}

-(void)moveDrone:(CGPoint)targetInit
{
    double xDesitination = targetInit.x;
    double yDesitination = targetInit.y;
    
    double dx = xDesitination - position.x;
    double dy = yDesitination - position.y;
    
    double hypotenuse = sqrt(dx*dx + dy*dy);
    
    double droneVelocity = 145;
    
    double droneTime = hypotenuse/droneVelocity;
    
    double vx = dx/droneTime;
    double vy = dy/droneTime;
    
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