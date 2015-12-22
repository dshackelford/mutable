//
//  Barracade.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Barracade.h"



@implementation Barracade

-(id)initBlockadeBarricadeElement:(Base*)baseInit Location:(CGPoint)locationInit View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit
{
    self = [super init];
    
    barricadeRadius = 50;
    
    size = CGSizeMake(23, 23);
    
    position = locationInit;
    
    imageFileName = @"blockadeElement";
    
    shapeCenter = [baseInit getPosition];
    
    shapeRadius = 50;
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}



-(void)move:(id)tracker
{
    [self moveInSquare];
}

-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    position = positionInit;
    
    size = CGSizeMake(23,23);
    
    shapeRadius = 50;
    
    imageFileName = @"blockadeElement";
    
    shapeCenter = [[objectArray objectAtIndex:0] getPosition];
    
    velocity = velocityInit;
    
    [self setImage];
    
    //I should put the gem image below the health image, see the init above
    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
    
    return self;
}


@end