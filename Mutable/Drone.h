//
//  Kamikaze.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "Base.h"
#import "Projectile.h"


//double angleOfRotation;

@interface Drone : Projectile
{

}
-(id)initDrone:(CGPoint)targetInit Container:(UIView*)viewInit PlaceHolderButton:(UIButton*)placeHolderButton;

-(void)droneMovement:(CGPoint)targetInit :(NSMutableArray*)droneArrayInit;

-(void)moveDrone:(CGPoint)targetInit;

-(void)detectCollision;

@end
