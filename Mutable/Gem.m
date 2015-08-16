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

-(void)initGem:(CGPoint)positionInit :(UIView *)container :(UIView *)healthImageInit
{

    position = positionInit;
    
    size = CGSizeMake(35,35);
    
    imageFileName = @"PointGem";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:healthImageInit];
    
//    [staticObjectArray addObject:self];
}



@end