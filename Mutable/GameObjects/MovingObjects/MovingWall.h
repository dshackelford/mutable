//
//  MovingWall.h
//  Mutable
//
//  Created by Dylan Shackelford on 12/22/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//


#import "Bullet.h"

@interface MovingWall : Bullet

{

}

+(void)createTheWall:(HeadLink*)theHeadLink View:(UIView*)container;

@end