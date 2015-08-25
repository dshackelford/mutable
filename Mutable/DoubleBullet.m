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
    
    double separation = 9;
    
    //CALCULATE STARTING AND TARGET POSITIONS FOR DOUBLE BULLETS THAT ARE SHIFTED RELATIVE TO ANGLE OF FIRE
    if (dx > 0 && dy < 0) //top right quadrant
    {
        bulletOneX = [headLinkInit getShapeCenter].x + sin(theta)*separation;
        bulletOneY = [headLinkInit getShapeCenter].y + cos(theta)*separation;
        
        bulletOneTargetX = targetInit.x + sin(theta)*separation;
        bulletOneTargetY = targetInit.y + cos(theta)*separation;
        
        bulletTwoTargetX = targetInit.x - sin(theta)*separation;
        bulletTwoTargetY = targetInit.y - cos(theta)*separation;
        
        bulletTwoX = [headLinkInit getShapeCenter].x - sin(theta)*separation;
        bulletTwoY = [headLinkInit getShapeCenter].y - cos(theta)*separation;

    }
    else if (dx < 0 && dy < 0) //top left quadrant
    {
        
        bulletOneX = [headLinkInit getShapeCenter].x + sin(theta)*separation;
        bulletOneY = [headLinkInit getShapeCenter].y - cos(theta)*separation;
        
        bulletOneTargetX = targetInit.x + sin(theta)*separation;
        bulletOneTargetY = targetInit.y - cos(theta)*separation;
        
        bulletTwoTargetX = targetInit.x - sin(theta)*separation;
        bulletTwoTargetY = targetInit.y + cos(theta)*separation;
        
        bulletTwoX = [headLinkInit getShapeCenter].x - sin(theta)*separation;
        bulletTwoY = [headLinkInit getShapeCenter].y + cos(theta)*separation;
        
    }
    else if (dx < 0 && dy > 0) //bottom left quadrant
    {
        bulletOneX = [headLinkInit getShapeCenter].x + sin(theta)*separation;
        bulletOneY = [headLinkInit getShapeCenter].y + cos(theta)*separation;
        
        bulletOneTargetX = targetInit.x + sin(theta)*separation;
        bulletOneTargetY = targetInit.y + cos(theta)*separation;
        
        bulletTwoTargetX = targetInit.x - sin(theta)*separation;
        bulletTwoTargetY = targetInit.y - cos(theta)*separation;
        
        bulletTwoX = [headLinkInit getShapeCenter].x - sin(theta)*separation;
        bulletTwoY = [headLinkInit getShapeCenter].y - cos(theta)*separation;
    }
    else
    {
        bulletOneX = [headLinkInit getShapeCenter].x + sin(theta)*separation;
        bulletOneY = [headLinkInit getShapeCenter].y - cos(theta)*separation;
        
        bulletOneTargetX = targetInit.x + sin(theta)*separation;
        bulletOneTargetY = targetInit.y - cos(theta)*separation;
        
        bulletTwoTargetX = targetInit.x - sin(theta)*separation;
        bulletTwoTargetY = targetInit.y + cos(theta)*separation;
        
        bulletTwoX = [headLinkInit getShapeCenter].x - sin(theta)*separation;
        bulletTwoY = [headLinkInit getShapeCenter].y + cos(theta)*separation;
    }
    
    
    CGPoint bulletOneInitialPosition = CGPointMake(bulletOneX, bulletOneY);
    
    CGPoint bulletOneTarget = CGPointMake(bulletOneTargetX, bulletOneTargetY);
    
    CGPoint bulletTwoTarget = CGPointMake(bulletTwoTargetX, bulletTwoTargetY);

    
    CGPoint bulletTwoInitialPosition = CGPointMake(bulletTwoX, bulletTwoY);
    
    Bullet* bulletOne = [[Bullet alloc] init];
    
    CGSize doubleBulletSize = CGSizeMake(7, 7);
    [bulletOne setSize:doubleBulletSize];
    
    
    
    [bulletOne initBullet:bulletOneTarget InitialPosition:bulletOneInitialPosition Size:doubleBulletSize Container:container PlaceHolder:placeHolderButtonInit];
    
    
    Bullet* bulletTwo = [[Bullet alloc] init];

    [bulletTwo setSize:doubleBulletSize];
    
    
    [bulletTwo initBullet:bulletTwoTarget InitialPosition:bulletTwoInitialPosition Size:doubleBulletSize Container:container PlaceHolder:placeHolderButtonInit];


}



@end