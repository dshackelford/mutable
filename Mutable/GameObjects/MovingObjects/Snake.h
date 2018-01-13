//
//  Snake.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovingObject.h"
#import "Bullet.h"
#import "MineField.h"
#import "HeadLink.h"
#import "Base.h"
#import "Gem.h"
#import "BlockadeElement.h"
#import "Drone.h"
#import "Arrow.h"
#import "TurretGun.h"


@interface Snake : MovingObject
{

    NSMutableArray* snakeArray;
    
    double snakeLength;
    
    UIView* snakesView;
}


-(id)initSnake: (double)snakeLengthInit headLink:(HeadLink*)headLinkInit container:(UIView*)containerInit button:(UIButton*)placeHolderButtonInit;


-(void)move:(HeadLink*)theHeadLink;


-(void)addLinksToSnake:(double)howManyInit headLink:(HeadLink*)headLinkInit container:(UIView*)containerInit;

-(void)removeHowManyLinksFromSnake:(double)howMany;

-(NSMutableArray*)getSnakeArray;

-(double)getSnakeLength;
-(void)setSnakeLength:(double)snakeLengthInit;

@end

