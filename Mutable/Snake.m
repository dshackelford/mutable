//
//  Snake.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snake.h"

@implementation Snake

-(id)initSnake:(double)snakeLengthInit headLink:(HeadLink *)headLinkInit container:(UIView *)containerInit button:(UIButton *)placeHolderButtonInit
{
    self = [super init];
    
    snakeArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i < snakeLengthInit; i = i + 1)
    {
        MovingObject* aLink = [[MovingObject alloc] initMovingObject:CGPointMake([headLinkInit getPosition].x - i*[headLinkInit getVelocity].dx*deltaTime,[headLinkInit getPosition].y - i*[headLinkInit getVelocity].dy*deltaTime) :[headLinkInit getVelocity] :[headLinkInit getSize] :@"Point"];

        [snakeArray addObject:aLink];
            
        [containerInit insertSubview:[aLink getImage] belowSubview:[headLinkInit getImage]];
    }
    
    [objectArray addObject:self];
    
    return self;
}


-(void)move:(id)objectTracker
{
    if ([snakeArray count] > 0)
    {
        BOOL hit = NO;
        
        for (double i = [snakeArray count] - 1; i > -1; i = i - 1)
        {
            MovingObject* aLink = [snakeArray objectAtIndex:i];
            
            if (i == 0) //link directly after the headlink
            {
                [aLink setPosition:[objectTracker getPosition]];
            }
            else
            {
                MovingObject* anotherLink = [snakeArray objectAtIndex:i - 1];
                
                [aLink setPosition:[anotherLink getPosition]];
            }
            
            [aLink getImage].center = [aLink getPosition];
            
            for (int i = 0;i < [objectArray count]; i = i + 1)
            {
                id object = [objectArray objectAtIndex:i];
                
                if (fabs([object getPosition].x - [aLink getPosition].x) < [object getSize].width/2 + [aLink getSize].width/2 && fabs([object getPosition].y - [aLink getPosition].y) < [object getSize].height/2 + [aLink getSize].height/2 && object != objectTracker && [object class] != [Bullet class])
                {
                    
                    for (int g = i; g < [snakeArray count]; g = g + 1)
                    {
                        [[[snakeArray objectAtIndex:g] getImage] removeFromSuperview];
                        [snakeArray removeObjectAtIndex:g];
                    }
                        
                    hit = YES;
                        
                    [[object getImage] removeFromSuperview];
                    [objectArray removeObject:object];
                        
                    break;
                    
                }
            }
            
            if (hit == YES)
            {
                break;
            }

        }
    }
    
//                if (i == 0) //link directly after the headlink
//                {
//                    [aLink setVelocity:[theHeadLink getVelocity]];
//                }
//                else
//                {
//                    MovingObject* anotherLink = [snakeArray objectAtIndex:i - 1];
//    
//                    [aLink setVelocity:[anotherLink getVelocity]];
//                }
//    
//                [aLink move];
//                
//        }
//    }
}


#pragma mark - Change Snake

-(void)removeHowManyLinksFromSnake:(double)howMany
{
    for (int i = 0; i < howMany; i = i + 1)
    {
        [[[snakeArray objectAtIndex:[snakeArray count] - 1] getImage] removeFromSuperview];
        [snakeArray removeLastObject];
    }
    
}

-(void)addLinksToSnake:(double)howManyInit headLink:(HeadLink*)headLinkInit container:(UIView *)containerInit
{
    
    if ([snakeArray count] > 1)
    {
        MovingObject* LastLinkInSnake = [snakeArray objectAtIndex:[snakeArray count] -1];
        MovingObject* nextLink = [snakeArray objectAtIndex:[snakeArray count] - 2];
        
        int directionalConstantX = 0;
        int directionalConstantY = 0;
        
        if ([LastLinkInSnake getPosition].x - [nextLink getPosition].x > 0) //
        {
            directionalConstantX = 1;
            directionalConstantY = 0;
            //add to the right
        }
        else if ([LastLinkInSnake getPosition].x - [nextLink getPosition].x < 0)
        {
            //add to the left
            directionalConstantX = -1;
            directionalConstantY = 0;
        }
        else if ([LastLinkInSnake getPosition].y - [nextLink getPosition].y > 0)
        {
            //add to the bottom
            directionalConstantX = 0;
            directionalConstantY = 1;
        }
        else
        {
            //add to the top
            directionalConstantX = 0;
            directionalConstantY = -1;
        }
    
        for (int i=1; i < howManyInit + 1; i = i + 1)
        {
            MovingObject* aLink = [[MovingObject alloc] initMovingObject:CGPointMake([LastLinkInSnake getPosition].x + directionalConstantX*i*2*fabs(snakeVelocity)*deltaTime,[LastLinkInSnake getPosition].y + directionalConstantY*i*2*fabs(snakeVelocity)*deltaTime) : CGVectorMake([LastLinkInSnake getVelocity].dx, [LastLinkInSnake getVelocity].dy) : [LastLinkInSnake getSize] :[LastLinkInSnake getImageFileName]];
        
            [snakeArray addObject:aLink];
        
            [containerInit insertSubview:[aLink getImage] belowSubview:[LastLinkInSnake getImage]];
        }
    }
    else
    {
        MovingObject* LastLinkInSnake = headLinkInit;
        
        int directionalConstantX = 0;
        int directionalConstantY = 0;
        
        if ([headLinkInit getVelocity].dx > 0)
        {
            directionalConstantX = -1;
            directionalConstantY = 0;
        }
        if ([headLinkInit getVelocity].dx < 0)
        {
            directionalConstantX = 1;
            directionalConstantY = 0;
        }
        if ([headLinkInit getVelocity].dy > 0)
        {
            directionalConstantX = 0;
            directionalConstantY = -1;
        }
        if ([headLinkInit getVelocity].dy < 0)
        {
            directionalConstantX = 0;
            directionalConstantY = 1;
        }
        
        
        for (int i=0; i < howManyInit; i = i + 1)
        {
            MovingObject* aLink = [[MovingObject alloc] initMovingObject:CGPointMake([headLinkInit getPosition].x + directionalConstantX*i*2*fabs([headLinkInit getVelocity].dx)*deltaTime, [headLinkInit getPosition].y + directionalConstantY*i*2*fabs([headLinkInit getVelocity].dy)*deltaTime) :CGVectorMake([headLinkInit getVelocity].dx, [headLinkInit getVelocity].dy) :[headLinkInit getSize] :@"Point"];
            
            
            [snakeArray addObject:aLink];
            
            [aLink getImage].center = [aLink getPosition];
            
            [containerInit insertSubview:[aLink getImage] belowSubview:[LastLinkInSnake getImage]];
        }
    }
}


#pragma mark - Getters


-(NSMutableArray*)getSnakeArray
{
    return snakeArray;
}

-(double)getSnakeLength
{
    return snakeLength;
}

-(void)setSnakeLength:(double)snakeLengthInit
{
    snakeLength = snakeLengthInit;
}

@end