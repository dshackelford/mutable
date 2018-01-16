//
//  Projectile.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/29/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"

@interface Projectile : MovingObject
{
    //CGPoint target;
    double angleOfRotation;
}


-(double)findAngleOfRotation;
-(void)setAngleOfRotation:(double)rotInit;
-(double)getAngleOfRotation;
@end
