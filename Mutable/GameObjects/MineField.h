//
//  Mine.h
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import "MovingObject.h"
#import "Base.h"
#import "Mine.h"

@interface MineField : Mine
{

}

+(void)makeRandomMineField:(Base*)baseInit headLink:(HeadLink*)headLinkInit container:(UIView*)containerInit placeholder:(UIButton*)placeHolderButton;

+(void)makeMineBarracade:(Base*)baseInit container:(UIView*)containerInit placeHolder:(UIButton*)placeHolderButton;
//add other mine configurations here...



@end
