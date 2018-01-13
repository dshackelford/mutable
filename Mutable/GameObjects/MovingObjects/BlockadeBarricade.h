//
//  BlockadeBarricade.h
//  Mutable
//
//  Created by Dylan Shackelford on 12/20/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//


#import "Barracade.h"

@interface BlockadeBarricade : Barracade


+(void)createBlockadeBarricade:(Base*)baseInit View:(UIView*)container PlaceHolder:(UIButton*)placeHolderButtonInit;

@end
