//
//  Shifting.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "MineField.h"
#import "BlockadeElement.h"

double shiftCounter;

@interface Shifting : Mine
{
    
}

+(void)shiftMineField:(NSMutableArray*)mineFieldInit;
+(void)showMineField:(NSMutableArray*)mineFieldInit;
@end