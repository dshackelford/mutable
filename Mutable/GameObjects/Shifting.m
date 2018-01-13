//
//  Shifting.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shifting.h"

@implementation Shifting

+(void)shiftMineField
{
    shiftCounter = shiftCounter +1;
    
    if (shiftCounter > 75)
    {
        for (int i = 0; i < [objectArray count]; i = i + 3)
        {
            BasicObject* object = [objectArray objectAtIndex:i];
            [object hide];
        }
        
        for (int i = 0; i < [objectArray count]; i = i + 3)
        {
            BasicObject* object = [objectArray objectAtIndex:i];
            [object show];
        }

    }
    
    if (shiftCounter > 75 && shiftCounter < 150)
    {
        for (int i = 0; i < [objectArray count]; i = i + 3)
        {
            BasicObject* object = [objectArray objectAtIndex:i];
            [object show];
        }
        
        for (int i = 0; i < [objectArray count]; i = i + 3)
        {
            BasicObject* object = [objectArray objectAtIndex:i];
            [object hide];
        }
    }
    
    if (shiftCounter >150)
    {
        shiftCounter = 0;
    }
}

+(void)showMineField
{
    
    for (Mine* aMine in objectArray)
    {
        [aMine show];
    }
    
    shiftCounter = 0;
}


@end