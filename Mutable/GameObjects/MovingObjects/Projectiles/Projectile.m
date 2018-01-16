//
//  Projectile.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/29/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Projectile.h"

@implementation Projectile

-(void)setAngleOfRotation:(double)rotInit
{
    angleOfRotation = rotInit;
}
-(double)getAngleOfRotation
{
    return angleOfRotation;
}

@end
