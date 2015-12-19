//
//  PowerUp.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gem.h"

@implementation Gem

#pragma mark - Inits
-(id)initGem:(CGPoint)positionInit :(UIView *)container :(UIView *)healthImageInit
{ 
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(19,26);
    
    imageFileName = @"PointGem";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:healthImageInit];
    
    [objectArray addObject:self];
    
    return self;

}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(19,26);
    
    imageFileName = @"PointGem";
    
    [self setImage];
    
    //I should put the gem image below the health image, see the init above
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}


#pragma mark - Interactions
-(void)crash
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YouWin" object:nil];
}

-(void)hit
{
    
}



@end