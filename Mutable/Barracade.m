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

+(NSMutableArray*)makeBlockadeBarracade:(CGPoint)basePosition View:(UIView *)viewInit PlaceHolder:(UIButton*)placeHolderButtonInit
{
    NSMutableArray* aBarracadeArray = [[NSMutableArray alloc] init];
    
    double barracadeRadius = 50;
    
    for (int i = 0; i < 4; i = i + 1)
    {
        BlockadeElement* aBlockadeElement = [[BlockadeElement alloc] init];
        
        CGPoint aPosition;
        CGVector aVelocity;
        
        if(i == 0) //bottom
        {
            aPosition = CGPointMake(basePosition.x, basePosition.y + barracadeRadius);
            aVelocity = CGVectorMake(-100, 0);
        }
        if(i == 1) //right
        {
            aPosition = CGPointMake(basePosition.x + barracadeRadius, basePosition.y);
            aVelocity = CGVectorMake(0, 100);
        }
        if(i == 2) //top
        {
            aPosition = CGPointMake(basePosition.x, basePosition.y - barracadeRadius);
            aVelocity = CGVectorMake(100, 0);
        }
        if(i == 3) //left
        {
            aPosition = CGPointMake(basePosition.x - barracadeRadius, basePosition.y);
            aVelocity = CGVectorMake(0, -100);
        }
        
        
        [aBlockadeElement createBlockadeElementForBarracade:aPosition  Center:basePosition View:viewInit PlaceHolder:placeHolderButtonInit];
        
        [aBlockadeElement setVelocity:aVelocity];
        [aBlockadeElement setShapeRadius:barracadeRadius*2];
         
        [aBarracadeArray addObject:aBlockadeElement];
    }
    
    return aBarracadeArray;
}


+(void)moveBlockadeBarracade:(NSMutableArray*)barracadeArrayInit BasePosition:(CGPoint)basePositionInit
{
    
//    double barracadeRadius = 40;
//    
//    Vector* topRightCorner = [[Vector alloc] init];
//    [topRightCorner setVector:[basePositionInit getX] + barracadeRadius/2 :[basePositionInit getY] - barracadeRadius/2];
//    
//    Vector* topLeftCorner = [[Vector alloc] init];
//    [topLeftCorner setVector:[basePositionInit getX] - barracadeRadius/2 :[basePositionInit getY] - barracadeRadius/2];
//    
//    Vector* bottomRightCorner = [[Vector alloc] init];
//    [bottomRightCorner setVector:[basePositionInit getX] + barracadeRadius/2 :[basePositionInit getY] + barracadeRadius/2];
//    
//    Vector* bottomLeftCorner = [[Vector alloc] init];
//    [bottomLeftCorner setVector:[basePositionInit getX] - barracadeRadius/2 :[basePositionInit getY] + barracadeRadius/2];
//    
//    
//    for (BlockadeElement* aBlockadeElement in barracadeArrayInit)
//    {
    
//    //turn down at top right corner
//    if ([[aBlockadeElement getPosition] getX] > [topRightCorner getX] && [[aBlockadeElement getPosition] getY] < [basePositionInit getY])
//    {
//        [aBlockadeElement setVelocityX:0];
//        [aBlockadeElement setVelocityY:200];
//    }
//    
//    //Go left at bottom right corner
//    if ([[aBlockadeElement getPosition] getX] > [basePositionInit getX] && [[aBlockadeElement getPosition] getY] > [bottomRightCorner getY])
//    {
//        [aBlockadeElement setVelocityX:-200];
//        [aBlockadeElement setVelocityY:0];
//    }
//    
//    
//    //turn up at bottom left corner
//    if ([[aBlockadeElement getPosition] getX] < [bottomLeftCorner getX] && [[aBlockadeElement getPosition] getY] > [basePositionInit getY] )
//    {
//        [aBlockadeElement setVelocityX:0];
//        [aBlockadeElement setVelocityY:-200];
//    }
//    
//    
//    //turn right at top left corner
//    if ([[aBlockadeElement getPosition] getY] < [topLeftCorner getY] && [[aBlockadeElement getPosition] getX] < [basePositionInit getX])
//    {
//        [aBlockadeElement setVelocityX:200];
//        [aBlockadeElement setVelocityY:0];
//    }
//        
//        
//        [aBlockadeElement setLatitude:[aBlockadeElement getLatitude] + [aBlockadeElement getVelocityX]*deltaTime];
//        [aBlockadeElement setLongitude:[aBlockadeElement getLongitude] + [aBlockadeElement getVelocityY]*deltaTime];
//        
//        [aBlockadeElement getImage].center = CGPointMake([aBlockadeElement getLatitude], [aBlockadeElement getLongitude]);
//    }
    
    
//    }
}


@end