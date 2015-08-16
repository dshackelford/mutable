//
//  Arrow.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arrow.h"


@implementation Arrow

-(void)initArrow:(CGPoint)targetPosition InitialPosition:(CGPoint)initialPosition Turret:(TurretGun*)turretGun container:(UIView*)container placeHolder:(UIButton*)placeHolderButton
{
    
    size = CGSizeMake(30, 15);
    
    imageFileName = @"arrow";
    
    if (shapeShiftBool == YES)
    {
        position = initialPosition;
    }
    else
    {
        position = [turretGun getPosition];
    }
    
    [self setImage];
    
    
    double dx = targetPosition.x - position.x;
    double dy = targetPosition.y - position.y;
    
    //bulletSpeed = 900;
    double bulletSpeed = 10000/size.width;
    
    double bulletTime = sqrt(dx*dx+dy*dy)/bulletSpeed;
    
    double Vx = dx/bulletTime;
    double Vy = dy/bulletTime;
    
    velocity = CGVectorMake(Vx, Vy);
    
    [container insertSubview: theImage belowSubview:placeHolderButton];
    
    
    
    double hypotenuse = sqrt(dx*dx + dy*dy);
    
    //ROTATE IMAGE FOR ASETHETIC PURPOSES
    if (dy > 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse) + M_PI_2;
    }
    if (dy > 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + M_PI_2;
    }
    
    if (dy < 0 && dx < 0)
    {
        angleOfRotation = acos(dy/hypotenuse) + M_PI_2;
    }
    
    if (dy < 0 && dx > 0)
    {
        angleOfRotation = 0 - acos(dy/hypotenuse) + M_PI_2;
    }
    
    
    [self getImage].transform = CGAffineTransformMakeRotation(angleOfRotation);
    
    [dynamicObjectArray addObject:self];
    
    
}

@end