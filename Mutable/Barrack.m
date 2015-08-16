 //
//  Barrack.m
//  Mutable
//
//  Created by Dylan Shackelford on 6/27/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Barrack.h"


@implementation Barrack
//
//-(void)establishBarrack:(Vector*)aPositionInit :(double)baseStrengthInit :(UIView *)container :(UIButton *)placeHolderButtonInit
//{
//    latitude = [aPositionInit getX];
//    longitude = [aPositionInit getY];
//    enemyBaseHealth = baseStrengthInit;
//    
//    theImage = [self makeBarrackImage];
//    
//    theImage.center = CGPointMake([aPositionInit getX], [aPositionInit getY]);
//    
//    healthArray = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < enemyBaseHealth; i = i + 1)
//    {
//        UIImageView* aHealthImage = [self makeHealthImageForBarrack];
//        
//        [container insertSubview:aHealthImage belowSubview:placeHolderButtonInit];
//        
//        [healthArray addObject:aHealthImage];
//        
//        aHealthImage.center = CGPointMake([aPositionInit getX] - 12 + 7*i, [aPositionInit getY]+1.5);
//    }
//    
//    [container insertSubview:theImage belowSubview:placeHolderButtonInit];
//}
//
//
//
//-(UIImageView*)makeBarrackImage
//{
//    CGRect barrackRect = CGRectMake(0, 0, 55, 55);
//    UIImageView* aBarrackImage = [[UIImageView alloc] initWithFrame:barrackRect];
//    aBarrackImage.image = [UIImage imageNamed:@"Barrack.png"];
//    return aBarrackImage;
//}
//
//-(UIImageView*)makeHealthImageForBarrack
//{
//    CGRect healthRect = CGRectMake(100, 150, 7, 30);
//    UIImageView* aHealthImage = [[UIImageView alloc]initWithFrame:healthRect];
//    aHealthImage.image = [UIImage imageNamed:@"health.png"];
//    return aHealthImage;
//}

@end