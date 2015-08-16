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
#import "Kamikaze.h"
#import "Arrow.h"
#import "TurretGun.h"


@interface Snake : MovingObject
{

    NSMutableArray* snakeArray;
    
    double snakeLength;
    
    UIView* snakesView;
}


-(void)initSnake: (double)snakeLengthInit headLink:(HeadLink*)headLinkInit container:(UIView*)containerInit button:(UIButton*)placeHolderButtonInit;


-(void)move:(HeadLink*)theHeadLink;

-(void)moveSnake:(HeadLink*)headLinkInit :(NSMutableArray*)mineFieldInit :(NSMutableArray*)blockadeArrayInit : (NSMutableArray*)kamikazeArrayInit : (Base*)enemyBaseInit : (Gem*)gemInit :(NSMutableArray*)LifePowerUpArrayInit View:(UIView*)viewInit Arrow:(NSMutableArray*)arrowArrayInit TurretGut:(TurretGun*)turretGunInit :(NSMutableArray*)blockadeBarricadeArrayInit;


-(void)addLinksToSnake:(double)howManyInit headLink:(HeadLink*)headLinkInit container:(UIView*)containerInit;
-(void)removeHowManyLinksFromSnake:(double)howMany;

-(NSMutableArray*)getSnakeArray;

-(double)getSnakeLength;
-(void)setSnakeLength:(double)snakeLengthInit;

@end

