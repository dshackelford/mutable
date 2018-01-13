//
//  Barracade.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/28/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "BlockadeElement.h"


@interface Barracade : MovingObject
{
    double barricadeRadius;
}


-(id)initBlockadeBarricadeElement:(Base*)baseInit Location:(CGPoint)locationInit View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit;

+(NSMutableArray*)makeBlockadeBarracade:(CGPoint)basePosition View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButtonInit;

+(void)moveBlockadeBarracade:(NSMutableArray*)barracadeArrayInit BasePosition:(CGPoint)basePositionInit;


@end