//
//  Arrow.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "Bullet.h"
#import "TurretGun.h"

@interface Arrow : Projectile
{
    
}

-(void)initArrow:(CGPoint)targetPosition InitialPosition:(CGPoint)initialPosition Turret:(TurretGun*)turretGun container:(UIView*)container placeHolder:(UIButton*)placeHolderButton;



@end