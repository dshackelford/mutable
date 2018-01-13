//
//  BasicObject.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicObject.h"

@implementation BasicObject

-(id)initBasicObject:(CGPoint)positionInit :(CGSize)sizeInit :(NSString*)imageFileStringInit
{
    self = [super init];
    
    imageFileName = imageFileStringInit;
    
    position = positionInit;
    
    size = sizeInit;
    
    [self setImage];
    
    [objectArray addObject:self];
    
    return self;
}


-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit
{
    self = [super init];
    
    position = positionInit;
    
    return self;
}


#pragma mark - Move
-(void)move
{
    
}

-(void)move:(id)objectTracker
{
    
}

#pragma mark - Interactions

-(void)crash
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeathNotification" object:self];
    NSLog(@"crash!");
}

-(void)hit
{
    [theImage removeFromSuperview];
    [objectArray removeObject:self];
}


-(void)hide
{

}

-(void)show
{

}



#pragma mark - Getters

-(CGPoint)getPosition
{
    return position;
}

-(UIImageView*)getImage
{
    return theImage;
}

-(CGSize)getSize
{
    return size;
}

-(NSString*)getImageFileName
{
    return imageFileName;
}

-(CGVector)getVelocity
{
    return velocity;
}


#pragma mark - Setters
-(void)setPosition:(CGPoint)pointInit
{
    position = pointInit;
}

-(void)setImage
{
    CGRect aRect = CGRectMake(position.x, position.y, size.width, size.height);
    UIImageView* anImage = [[UIImageView alloc]initWithFrame:aRect];
    anImage.image = [UIImage imageNamed:[imageFileName stringByAppendingString:@".png"]];
    
    theImage = anImage;
    
    theImage.center = position;
}

-(void)setSize:(CGSize)sizeInit
{
    size = sizeInit;
}

-(void)setSize:(double)xInit :(double)yInit
{
    size = CGSizeMake(xInit, yInit);
}


@end