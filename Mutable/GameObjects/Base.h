//
//  Base.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "HeadLink.h"


@interface Base : BasicObject
{
    NSMutableArray* healthArray;
    
    double enemyBaseHealth;
    
    double healthCounter;
    
    double baseHealthCap;
    
    BOOL regneration;
}

-(id)initBase:(HeadLink*)headLinkInit :(double)baseStrengthInit :(UIView*)container :(UIButton*)placeHolderButtonInit locationOverRide:(BOOL)locationOverRide Position:(CGPoint)positionInit;


-(void)addHealth:(UIView*)container :(UIButton*)placeHolderButtonInit;

-(void)hit;

-(UIImageView*)getHealthBarImage;

-(double)getEnemyBaseHealth;
-(double)getBaseHealthCap;
-(BOOL)getRegeneration;

-(UIImageView*)makeHealthImage;

@end

