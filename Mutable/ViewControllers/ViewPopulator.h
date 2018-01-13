//
//  ViewPopulator.h
//  Mutable
//
//  Created by Dylan Shackelford on 12/24/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//


@interface ViewPopulator : NSObject
{
    double viewCounter;
    double blockadeCounter;
    double droneCounter;
    double lifePowerUpCounter;
    double turretGunCounter;
    
    NSMutableArray* lifePowerUpArray;
}

-(void)prepViewPopulator;

-(void)populateView:(HeadLink*)levelHeadLink Base:(Base*)levelEnemyBase TurretGun:(TurretGun*)levelTurretGun View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButton;

@end
