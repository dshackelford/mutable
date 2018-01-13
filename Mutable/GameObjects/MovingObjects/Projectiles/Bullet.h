//
//  Bullet.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovingObject.h"
#import "Snake.h"
#import "HeadLink.h"
#import "TurretGun.h"
#import "Projectile.h"

@interface Bullet : Projectile
{
    
    double targetX;
    double targetY;
    
    double dx;
    double dy;
    
    double Vx;
    double Vy;
    
    double bulletSpeed;
    double bulletTime;
    
    BOOL didBulletHit;
    
    BOOL wallBool;
    
}

-(id)initBullet:(CGPoint)targetInit InitialPosition:(CGPoint)initialPosition Size:(CGSize)sizeInit Container:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit;


-(void)detectCollision;

-(void)setWallBool:(BOOL)boolInit;

@end