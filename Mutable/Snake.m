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

-(void)initSnake:(double)snakeLengthInit headLink:(HeadLink *)headLinkInit container:(UIView *)containerInit button:(UIButton *)placeHolderButtonInit
{
    
    snakeArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i < snakeLengthInit; i = i + 1)
    {
        MovingObject* aLink = [[MovingObject alloc] init];

        [aLink initMovingObject:CGPointMake([headLinkInit getLatitude] - i*[headLinkInit getVelocity].dx*deltaTime,[headLinkInit getLongitude] - i*[headLinkInit getVelocity].dy*deltaTime) :[headLinkInit getVelocity] :[headLinkInit getSize] :@"Point"];

        [snakeArray addObject:aLink];
            
        [containerInit insertSubview:[aLink getImage] belowSubview:[headLinkInit getImage]];
    }
    
//    [dynamicObjectArray addObject:self];
}


-(void)move:(HeadLink*)theHeadLink
{
    if ([snakeArray count] > 0)
    {
        for (double i = [snakeArray count] - 1; i > -1; i = i - 1)
        {
            MovingObject* aLink = [snakeArray objectAtIndex:i];
            
            if (i == 0) //link directly after the headlink
            {
                [aLink setPosition:[theHeadLink getPosition]];
            }
            else
            {
                MovingObject* anotherLink = [snakeArray objectAtIndex:i - 1];
                
                [aLink setPosition:[anotherLink getPosition]];
            }
            
            [aLink getImage].center = [aLink getPosition];
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


-(void)moveSnake: (HeadLink*)headLinkInit :(NSMutableArray*)mineFieldInit :(NSMutableArray*)blockadeArrayInit :(NSMutableArray*)kamikazeArrayInit :(Base*)enemyBaseInit :(Gem*)gemInit :(NSMutableArray*)LifePowerUpArrayInit View:(UIView *)viewInit Arrow:(NSMutableArray*)arrowArrayInit TurretGut:(TurretGun*)turretGunInit :(NSMutableArray*)blockadeBarricadeArrayInit
{
    
    if ([snakeArray count] > 0)
    {
        for (double i = [snakeArray count] - 1; i > -1; i = i - 1)
        {
            MovingObject* aLink = [snakeArray objectAtIndex:i];
        
            if (i == 0) //link directly after the headlink
            {
                [aLink setPosition:[headLinkInit getPosition]];
            }
            else
            {
                MovingObject* anotherLink = [snakeArray objectAtIndex:i - 1];
                
                [aLink setPosition:[anotherLink getPosition]];
            }
        
            [aLink getImage].center = [aLink getPosition];


            
            
//            if (i == 0) //link directly after the headlink
//            {
//                [aLink setVelocity:[headLinkInit getVelocity]];
//            }
//            else
//            {
//                MovingObject* anotherLink = [snakeArray objectAtIndex:i - 1];
//                
//                [aLink setVelocity:[anotherLink getVelocity]];
//            }
//            
//            [aLink move];
//            
//            
            
            //---------------------------------------------
            
            //BLOCKADE DAMAGE
            for(BlockadeElement* aBlockadeElement in blockadeArrayInit)
            {
                if (fabs([aBlockadeElement getLatitude] - [aLink getLatitude]) < 12 && fabs([aBlockadeElement getLongitude] - [aLink getLongitude]) < 12)
                {
                    if(i ==1)
                    {
                        gameStatus = NO;
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeathNotification" object:self];
                        
                        break;
                        
                    }
                    else
                    {
                        for (int g = i; g < [snakeArray count]; g = g +1)
                        {
                            [[[snakeArray objectAtIndex:g] getImage] removeFromSuperview];
                            [snakeArray removeObjectAtIndex:g];
                        }
                    }
                }
            }
            
            for (BlockadeElement* aBlockadeBarricadeElement in blockadeBarricadeArrayInit)
            {
                if (fabs([aBlockadeBarricadeElement getLatitude] - [aLink getLatitude]) < 12 && fabs([aBlockadeBarricadeElement getLongitude] - [aLink getLongitude]) < 12)
                {
                    if(i ==1)
                    {
                        gameStatus = NO;
                        break;
                    }
                    else
                    {
                        for (int g = i; g < [snakeArray count]; g = g +1)
                        {
                            [[[snakeArray objectAtIndex:g] getImage] removeFromSuperview];
                            [snakeArray removeObjectAtIndex:g];
                        }
                    }
                }
            }

            //KAMIKAZI DAMAGE
            for (int l = 0; l < [kamikazeArrayInit count]; l = l  +1)
            {
                MovingObject* aKamikazi = [kamikazeArrayInit objectAtIndex:l];
        
                UIImageView* aKamikaziImage = [aKamikazi getImage];
        
                if (fabs([aKamikazi getLatitude]- [aLink getLatitude]) < 10 && fabs([aKamikazi getLongitude] - [aLink getLongitude]) < 10)
                {
                    if (i == 1)
                    {
                        gameStatus = NO; //YOU LOST
                        break;
                    }
                    else
                    {
        
                        for (int g = i; g < [snakeArray count]; g = g + 1)
                        {
                            [[[snakeArray objectAtIndex:g] getImage] removeFromSuperview];
                            [snakeArray removeObjectAtIndex:g];
                        }
                    }
                    
                    [aKamikaziImage removeFromSuperview];
                    [kamikazeArrayInit removeObjectAtIndex:l];
                }
                
            }
            
            for (int q = 0; q < [arrowArrayInit count]; q = q + 1)
            {
                Arrow* anArrow = [arrowArrayInit objectAtIndex:q];
                
                if (fabs([anArrow getPosition].x - [aLink getPosition].x) < 10 && fabs([anArrow getPosition].y - [aLink getPosition].y) < 10)
                {
                    if (i == 1)
                    {
                        gameStatus = NO;
                        break;
                    }
                    else
                    {
                        for (int w = i; w < [snakeArray count]; w = w + 1)
                        {
                            [[[snakeArray objectAtIndex:w] getImage] removeFromSuperview];
                            [snakeArray removeObjectAtIndex:w];
                        }
                    }
                    [[anArrow getImage] removeFromSuperview];
                    [arrowArrayInit removeObjectAtIndex:q];
                }
            }
        
        }
    }
    
    //INTERACTION WITH HEADLINK, NOT THE SNAKE BODY
    //MINEFIELD DAMAGE
    for (int j = 0; j < [mineFieldInit count]; j = j + 1)
    {
        if (fabs([headLinkInit getImage].center.x - [[mineFieldInit objectAtIndex:j] getImage].center.x) < 16 && fabs([headLinkInit getImage].center.y - [[mineFieldInit objectAtIndex:j] getImage].center.y) < 16)
        {
            gameStatus = NO;//YOU LOST
            break;
        }
    }
    
    
     //BLOCKADE DAMAGE
    for (int k = 0; k < [blockadeArrayInit count]; k = k + 1)
    {
        UIImageView* blockadeImage = [[blockadeArrayInit objectAtIndex:k] getImage];

        if (fabs(blockadeImage.center.x - [headLinkInit getImage].center.x) < 12 && fabs(blockadeImage.center.y - [headLinkInit getImage].center.y) < 12)
        {
            gameStatus = NO;
            break;
        }
        
    }
    
    //BLOCKADE BARRICADE DAMAGE
    for (BlockadeElement* aBlockadeBarricadeElement in blockadeBarricadeArrayInit)
    {
        if (fabs([aBlockadeBarricadeElement getLatitude] - [headLinkInit getLatitude]) < 12 && fabs([aBlockadeBarricadeElement getLongitude] - [headLinkInit getLongitude]) < 12)
        {

            gameStatus = NO;
            break;
        }
        
    }
    
    //KAMIKAZI DAMAGE
    for (Kamikaze* aKamikaze in kamikazeArrayInit)
    {
        if (fabs([aKamikaze getLatitude] - [headLinkInit getLatitude]) < 10 && fabs([aKamikaze getLongitude] - [headLinkInit getLongitude]) < 10)
        {
            gameStatus = NO;
            [[aKamikaze getImage] removeFromSuperview];
            break;
        }
    }
    
    
    for (int l = 0; l < [kamikazeArrayInit count]; l = l  +1)
    {
        MovingObject* aKamikazi = [kamikazeArrayInit objectAtIndex:l];
            
        UIImageView* aKamikaziImage = [aKamikazi getImage];

        
        if (fabs(aKamikaziImage.center.x - [headLinkInit getImage].center.x) < 10 && fabs(aKamikaziImage.center.y - [headLinkInit getImage].center.y) < 10)
        {
            gameStatus = NO;
            break;
        }
    }
    
    //BASE DAMAGE
    if ([enemyBaseInit getEnemyBaseHealth] > 0)
    {
        if (fabs([enemyBaseInit getLatitude] - [headLinkInit getLatitude]) < 22 && fabs([enemyBaseInit getLongitude] - [headLinkInit getLongitude]) < 22)
        {
            gameStatus = NO;
        }
            
    }
    
    if ([turretGunInit getTurretHealth] > 0)
    {
        if (fabs([turretGunInit getPosition].x - [headLinkInit getPosition].x) < [turretGunInit getSize].width/2 && fabs([turretGunInit getPosition].y - [headLinkInit getPosition].y) < [turretGunInit getSize].height/2)
        {
            gameStatus = NO;
        }
    }
    
    for (int q = 0; q < [arrowArrayInit count]; q = q + 1)
    {
        Arrow* anArrow = [arrowArrayInit objectAtIndex:q];
        
        if (fabs([anArrow getPosition].x - [headLinkInit getPosition].x) < 10 && fabs([anArrow getPosition].y - [headLinkInit getPosition].y) < 10)
        {
            gameStatus = NO;
        }
    }

    
    //GEM INTERACTION
    if (fabs([gemInit getLatitude] - [headLinkInit getLatitude]) < 7 && fabs([gemInit getLongitude] - [headLinkInit getLongitude]) < 19)
    {
        won = YES;
    }
    
    //LIFE POWER UP INTERACTION
    for (int s = 0; s < [LifePowerUpArrayInit count]; s = s + 1)
    {
        Gem* aLifePowerUp = [LifePowerUpArrayInit objectAtIndex:s];
        
        if (fabs([aLifePowerUp getLatitude] - [headLinkInit getLatitude]) < 15 && fabs([aLifePowerUp getLongitude] - [headLinkInit getLongitude]) < 15)
        {
            [[aLifePowerUp getImage] removeFromSuperview];
            [LifePowerUpArrayInit removeObjectAtIndex:s];
            [self addLinksToSnake:15 headLink:headLinkInit container:viewInit];
        }
    }
    
}


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
    
    if ([snakeArray count]>1)
    {
        MovingObject* LastLinkInSnake = [snakeArray objectAtIndex:[snakeArray count] -1];
        MovingObject* nextLink = [snakeArray objectAtIndex:[snakeArray count] - 2];
        
        int directionalConstantX = 0;
        int directionalConstantY = 0;
        
        if ([LastLinkInSnake getLatitude] - [nextLink getLatitude] > 0) //
        {
            directionalConstantX = 1;
            directionalConstantY = 0;
            //add to the right
        }
        else if ([LastLinkInSnake getLatitude] - [nextLink getLatitude] < 0)
        {
            //add to the left
            directionalConstantX = -1;
            directionalConstantY = 0;
        }
        else if ([LastLinkInSnake getLongitude] - [nextLink getLongitude] > 0)
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
            MovingObject* aLink = [[MovingObject alloc] init];
        
            //we should find the direction by find the differenve between two links!
        
            [aLink initMovingObject:CGPointMake([LastLinkInSnake getPosition].x + directionalConstantX*i*2*fabs(snakeVelocity)*deltaTime,[LastLinkInSnake getPosition].y + directionalConstantY*i*2*fabs(snakeVelocity)*deltaTime) : CGVectorMake([LastLinkInSnake getVelocity].dx, [LastLinkInSnake getVelocity].dy) : [LastLinkInSnake getSize] :[LastLinkInSnake getImageFileName]];
        
            [snakeArray addObject:aLink];
        
//            [aLink getImage].center = CGPointMake([aLink getLatitude], [aLink getLongitude]);
        
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
            MovingObject* aLink = [[MovingObject alloc] init];
            
            
            [aLink initMovingObject:CGPointMake([headLinkInit getPosition].x + directionalConstantX*i*2*fabs([headLinkInit getVelocity].dx)*deltaTime, [headLinkInit getPosition].y + directionalConstantY*i*2*fabs([headLinkInit getVelocity].dy)*deltaTime) :CGVectorMake([headLinkInit getVelocity].dx, [headLinkInit getVelocity].dy) :[headLinkInit getSize] :@"Point"];
            
            
            [snakeArray addObject:aLink];
            
            [aLink getImage].center = [aLink getPosition];
            
            [containerInit insertSubview:[aLink getImage] belowSubview:[LastLinkInSnake getImage]];
        }
    }
}



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