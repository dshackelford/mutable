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
    
}

+(NSMutableArray*)makeBlockadeBarracade:(CGPoint)basePosition View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButtonInit;

+(void)moveBlockadeBarracade:(NSMutableArray*)barracadeArrayInit BasePosition:(CGPoint)basePositionInit;


@end