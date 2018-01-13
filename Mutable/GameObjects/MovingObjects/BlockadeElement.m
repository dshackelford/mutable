//
//  Blockade.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockadeElement.h"

@implementation BlockadeElement

-(id)initBlockadeElement:(UIView*)container :(UIButton*)buttonInit
{
    self = [super init];
    
    int locationDeterminant = arc4random()%100; //DETERMINES FROM TOP BOTTOM LEFT OR RIGHT FOR START PATH
    
    //GO FROM BOTTOM
    if(locationDeterminant < 25)
    {
        position.x = arc4random()%(int)screenWidth;
        position.y = screenHeight + 5;
        velocity.dx = 0;
        velocity.dy = -200;
    }
    //GO FROM LEFTSIDE
    else if(locationDeterminant > 25 && locationDeterminant < 50)
    {
        position.x = -5;
        position.y = arc4random()%(int)screenHeight;
        velocity.dx = 200;
        velocity.dy = 0;
    }
    //GO FROM TOP
    else if(locationDeterminant > 50 && locationDeterminant < 75)
    {
        position.x = arc4random()%(int)screenWidth;
        position.y = -5;
        velocity.dx = 0;
        velocity.dy = 200;
    }
    //GO FROM RIGHTSIDE
    else
    {
        position.x = screenWidth + 5;
        position.y = arc4random()%(int)screenHeight;
        velocity.dx = -200;
        velocity.dy = 0;
    }
    
    size = CGSizeMake(23, 23);
    
    imageFileName = @"blockadeElement";
    
    [self setImage];
    
    [container insertSubview:theImage belowSubview:buttonInit];
    
    [objectArray addObject:self];
    
    return self;
}


-(void)createBlockadeElementForBarracade:(CGPoint)initialPositionInit Center:(CGPoint)centerPosition View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButtonInit
{
    position.x = initialPositionInit.x;
    position.y = initialPositionInit.y;
    
    shapeCenter = centerPosition;
    
    size = CGSizeMake(23, 23);
    
    imageFileName = @"blockadeElement";
    
    [self setImage];
    
    [viewInit insertSubview:theImage belowSubview:placeHolderButtonInit];
    
    [objectArray addObject:self];
}




-(void)move:(id)objectTracker
{
    [self move];
    
    if (position.x > (screenWidth + 15) || position.x < -15)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }
    
    if (position.y > (screenHeight + 15) || position.y < -15)
    {
        [theImage removeFromSuperview];
        [objectArray removeObject:self];
    }

}




@end