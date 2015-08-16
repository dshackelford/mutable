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

+(NSMutableArray*)makeTriangleSquadron:(CGPoint)targetPosition container:(UIView *)containerInit placeHolder:(UIButton *)placeHolderButton
{

    //this needs a lot of work, use the double bullet math to make this work
    
    double x = screenWidth + 10;
    double y = arc4random()%(int)screenHeight;
    
    CGPoint aPosition = CGPointMake(x, y);
    
    NSMutableArray* triangleSquadronArray = [[NSMutableArray alloc] init];
    
    Kamikaze* leaderKamikaze = [[Kamikaze alloc] init];
    
    [leaderKamikaze initKamikaze:aPosition Container:containerInit PlaceHolderButton:placeHolderButton];
    
    
    [triangleSquadronArray addObject:leaderKamikaze];
    
    
    Kamikaze* leftWingKamikaze = [[Kamikaze alloc] init];
    [leftWingKamikaze initKamikaze:CGPointMake(targetPosition.x - 35, targetPosition.y - 35) Container:containerInit PlaceHolderButton:placeHolderButton];
    
    [triangleSquadronArray addObject:leftWingKamikaze];
    
    
    Kamikaze* rightWingKamikaze = [[Kamikaze alloc] init];
    
    [rightWingKamikaze initKamikaze:CGPointMake(targetPosition.x + 35, targetPosition.y - 35) Container:containerInit PlaceHolderButton:placeHolderButton];

    
    [triangleSquadronArray addObject:rightWingKamikaze];
    
    return triangleSquadronArray;
    
}

@end