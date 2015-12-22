//
//  DoubleBullet.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/27/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubleBullet.h"

@implementation DoubleBullet

-(void)createDoubleBullet:(HeadLink*)headLinkInit container:(UIView*)container placeHolder:(UIButton*)placeHolderButtonInit Target:(CGPoint)targetInit
{
    dx = targetInit.x - [headLinkInit getShapeCenter].x;
    dy = targetInit.y - [headLinkInit getShapeCenter].y;
    
    double theta = fabs(atan(dy/dx));
    
    double separation = 11;
    
    //CALCULATE STARTING AND TARGET POSITIONS FOR DOUBLE BULLETS THAT ARE SHIFTED RELATIVE TO ANGLE OF FIRE
    
    for (int i = -1; i < 2; i = i + 2)
    {
        if (dx > 0 && dy < 0) //top right quadrant
        {
            bulletX = [headLinkInit getShapeCenter].x + i*sin(theta)*separation;
            bulletY = [headLinkInit getShapeCenter].y + i*cos(theta)*separation;
            
            targetX = targetInit.x + i*sin(theta)*separation;
            targetY = targetInit.y + i*cos(theta)*separation;
        }
        else if (dx < 0 && dy < 0) //top left quadrant
        {
            bulletX = [headLinkInit getShapeCenter].x + i*sin(theta)*separation;
            bulletY = [headLinkInit getShapeCenter].y - i*cos(theta)*separation;
            
            targetX = targetInit.x + i*sin(theta)*separation;
            targetY = targetInit.y - i*cos(theta)*separation;
        }
        else if ( dx < 0 && dy > 0)//bottom left quadrant
        {
            bulletX = [headLinkInit getShapeCenter].x + i*sin(theta)*separation;
            bulletY = [headLinkInit getShapeCenter].y + i*cos(theta)*separation;
            
            targetX = targetInit.x + i*sin(theta)*separation;
            targetY = targetInit.y + i*cos(theta)*separation;
        }
        else //bottom right
        {
            bulletX = [headLinkInit getShapeCenter].x + i*sin(theta)*separation;
            bulletY = [headLinkInit getShapeCenter].y - i*cos(theta)*separation;
            
            targetX = targetInit.x + i*sin(theta)*separation;
            targetY = targetInit.y - i*cos(theta)*separation;
        }

        
        [[Bullet alloc] initBullet:CGPointMake(targetX, targetY) InitialPosition:CGPointMake(bulletX, bulletY) Size:CGSizeMake(7, 7) Container:container PlaceHolder:placeHolderButtonInit];
    }
}



@end