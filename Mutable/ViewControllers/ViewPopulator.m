//
//  ViewPopulator.m
//  Mutable
//
//  Created by Dylan Shackelford on 12/24/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovingObject.h"
#import "TurretGun.h"
#import "BlockadeElement.h"
#import "Drone.h"
#import "Food.h"
#import "Arrow.h"
#import "ViewPopulator.h"

@implementation ViewPopulator


-(void)prepViewPopulator
{
    lifePowerUpArray = [[NSMutableArray alloc] init];
    viewCounter = 0;
    droneCounter = 0;
    blockadeCounter = 0;
    lifePowerUpCounter = 0;
    turretGunCounter = 0;
}

-(void)populateView:(HeadLink*)levelHeadLink Base:(Base*)levelEnemyBase TurretGun:(TurretGun*)levelTurretGun View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButton
{
    viewCounter = viewCounter + 1;
    
    //MAKE BLOCKADE ELEMENT
    if (currentLevel > 2)
    {
        blockadeCounter = blockadeCounter + 1;
        
        if (blockadeCounter > 200)
        {
            [[BlockadeElement alloc] initBlockadeElement: container : placeHolderButton];
            
            blockadeCounter = 0;
        }
    }
    
    //MAKE DRONES
    if (currentLevel > 15)
    {
        if (line == NO) //LINE MAKES SNAKE HIDE FROM DRONES
        {
            droneCounter = droneCounter + 1;
            
            if (droneCounter > 250)
            {
                droneCounter = 0;
                
                [[Drone alloc] initDrone:[levelHeadLink getPosition] Container:container PlaceHolderButton:placeHolderButton];
            }
        }
    }
    
    //MAKE LIFE POWER UPS
    if (globalSnakeLength < 40)
    {
        lifePowerUpCounter = lifePowerUpCounter + 1;
        
        if ([lifePowerUpArray count] < 4)
        {
            if (lifePowerUpCounter > 400)
            {
                lifePowerUpCounter = 0;
                
                Food* aFood = [[Food alloc] initFood:levelEnemyBase View:container placeHolder:placeHolderButton];
                
                [lifePowerUpArray addObject:aFood];
            }
        }
    }
    
    //MAKE TURRET GUN FIRE BULLETS
    if (currentLevel > 12 && line == NO)
    {
        turretGunCounter = turretGunCounter + 1;
        
        if ([levelTurretGun getTurretHealth] > 0)
        {
            if (turretGunCounter > 100)
            {
                turretGunCounter = 0;
                
                CGPoint theTarget = [levelHeadLink getPosition];
                
                [[Arrow alloc] initArrow:theTarget InitialPosition:[levelTurretGun getPosition] Turret:levelTurretGun container:container placeHolder:placeHolderButton];
            }
        }
    }
}

@end