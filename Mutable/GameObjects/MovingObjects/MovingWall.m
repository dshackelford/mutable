//
//  MovingWall.m
//  Mutable
//
//  Created by Dylan Shackelford on 12/22/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovingWall.h"
#import "MovingObject.h"
#import "WallLink.h"
#import "AppConstants.h"

@implementation MovingWall

+(void)createTheWall:(HeadLink*)theHeadLink View:(UIView*)container
{
    //add a lot of links in a circle
    //set their velocities to a ciricle
    
    double theta = 0;
    double wallRadius = 50;
    double numberOfLinks = 8;
    
    for (int i = 0; i < numberOfLinks; i = i + 1)
    {
        double cosine = cos(theta);
        double sine = sin(theta);
        
        CGPoint location = CGPointMake([theHeadLink getShapeCenter].x + cos(theta)*wallRadius, [theHeadLink getShapeCenter].y + sin(theta)*wallRadius);
        
        CGVector velocity = CGVectorMake(snakeVelocity*cos(theta)/50, snakeVelocity*sin(theta)/50);
        
        theta = theta + 2*3.1456/numberOfLinks;
        
        Bullet*  aWallBullet = [[Bullet alloc] initBullet:location InitialPosition:location Size:CGSizeMake(10, 10) Container:container PlaceHolder:[theHeadLink getImage]];
                                
        
        [aWallBullet setVelocity:velocity];
        
        [aWallBullet setShapeCenter:[theHeadLink getShapeCenter]];
        
        [aWallBullet setWallBool:YES];
        
        [aWallBullet setShapeRadius:wallRadius];
    }

}

@end