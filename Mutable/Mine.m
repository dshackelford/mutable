//
//  Mine.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/25/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine.h"

@implementation Mine

-(id)initMine:(CGPoint)positionInit :(UIView*)container :(UIButton*)placeHolderButtonInit
{
    character = @"Bad";
    
    self = [super init];
    
    size = CGSizeMake(28, 28);
    
    position = positionInit;
    
    imageFileName = @"mineImage2";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}


-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    size = CGSizeMake(28, 28);
    
    position = positionInit;
    
    imageFileName = @"mineImage2";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}

@end
