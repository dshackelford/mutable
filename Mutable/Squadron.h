//
//  Squadron.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "Base.h"
#import "Kamikaze.h"
#import "HeadLink.h"

@interface Squadron : Kamikaze
{
    int squadronCount;
    NSString* squadronShape; //circle, square, triangle
}


+(NSMutableArray*)makeTriangleSquadron:(CGPoint)targetPosition container:(UIView*)containerInit placeHolder:(UIButton*)placeHolderButton;




@end