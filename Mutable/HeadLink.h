//
//  HeadLink.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"


@interface HeadLink : MovingObject
{

    //what if the booleans for shape were headlink attributes, just add getters to make levelController work
}


-(id)initHeadLink:(CGPoint)positionInit Velocity:(CGVector)velocityInit View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButton;

-(void)detectCollision;

@end