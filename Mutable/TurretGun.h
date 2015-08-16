//
//  TurretGun.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/8/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//


#import "MovingObject.h"
#import "HeadLink.h"
#import "Base.h"

@interface TurretGun : MovingObject
{
    BOOL moving;
    
    double turretHealth;
    
    NSMutableArray* turretHealthArray;
}


-(void)initTurretGun:(HeadLink*)theHeadLink Base:(Base*)baseInit LocationOverRide:(BOOL)locationOverRide Position:(CGPoint)positionInit Velocity:(CGVector)velocityInit View:(UIView *)viewInit PlaceHolder:(UIButton *)placeHolderButton;


-(void)move;


-(void)hitTurret;
-(UIImageView*)getHealthBarImage;
-(double)getTurretHealth;

-(UIImageView*)makeHealthImage;

-(BOOL)getTurretMovingBoolean;

@end