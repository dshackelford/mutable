//
//  Squadron.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Squadron.h"

@implementation Squadron

+(void)makeTriangleSquadron:(CGPoint)targetPosition container:(UIView *)containerInit placeHolder:(UIButton *)placeHolderButton
{

    //this needs a lot of work, use the double bullet math to make this work
    
    double x = screenWidth + 10;
    double y = arc4random()%(int)screenHeight;
    
    CGPoint aPosition = CGPointMake(x, y);
    
    NSMutableArray* triangleSquadronArray = [[NSMutableArray alloc] init];
    
    Drone* leaderDrone = [[Drone alloc] init];
    
    [leaderDrone initDrone:aPosition Container:containerInit PlaceHolderButton:placeHolderButton];
    
    
    [triangleSquadronArray addObject:leaderDrone];
    
    
    Drone* leftWingDrone = [[Drone alloc] init];
    [leftWingDrone initDrone:CGPointMake(targetPosition.x - 35, targetPosition.y - 35) Container:containerInit PlaceHolderButton:placeHolderButton];
    
    [triangleSquadronArray addObject:leftWingDrone];
    
    
    Drone* rightWingKamikaze = [[Drone alloc] init];
    
    [rightWingKamikaze initDrone:CGPointMake(targetPosition.x + 35, targetPosition.y - 35) Container:containerInit PlaceHolderButton:placeHolderButton];

    
    [triangleSquadronArray addObject:rightWingKamikaze];
}

@end