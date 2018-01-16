//
//  Arrow.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "Bullet.h"
#import "TurretGun.h"
#import "Projectile.h"

@interface Arrow : Projectile
{
    
}

-(id)initArrow:(CGPoint)targetPosition InitialPosition:(CGPoint)initialPosition Turret:(TurretGun*)turretGun container:(UIView*)container placeHolder:(UIButton*)placeHolderButton;

-(void)detectCollision;
-(void)hit;


@end
