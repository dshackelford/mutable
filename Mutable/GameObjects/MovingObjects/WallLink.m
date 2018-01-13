//
//  WallLink.m
//  Mutable
//
//  Created by Dylan Shackelford on 12/22/15.
//  Copyright © 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallLink.h"


@implementation WallLink

//-(id)initWallLink
//{
//    self = [super init];
//    
//    imageFileName = @"Point";
//    
//    size = sizeInit;
//    
//    [self setImage];
//
//    [container insertSubview: theImage belowSubview:placeHolderButtonInit];
//    
//    [objectArray addObject:self];
//    
//    //set shape center
//    //set location
//    
//    return  self;
//}

-(void)move:(id)objectTracker
{
    [self moveInCircle];
}

@end