//
//  Blockade.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "MineField.h"

@interface BlockadeElement : MovingObject
{
    
}

-(void)initBlockadeElement:(UIView*)container :(UIButton*)buttonInit;

-(void)createBlockadeElementForBarracade:(CGPoint)initialPositionInit Center:(CGPoint)centerPosition View:(UIView*)viewInit PlaceHolder:(UIButton*)placeHolderButtonInit;


-(void)move:(NSMutableArray*)blockadeArrayInit;


@end