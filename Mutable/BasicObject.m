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


-(void)initBasicObject:(CGPoint)positionInit :(CGSize)sizeInit :(NSString*)imageFileStringInit
{
    
    imageFileName = imageFileStringInit;
    
    position = positionInit;
    
    size = sizeInit;
    
    [self setImage];
    
//    [staticObjectArray addObject:self];
}


-(double)getLatitude
{
    return position.x;
}

-(double)getLongitude
{
    return position.y;
}


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



-(void)setLatitude:(double)latitudeInit
{
    position.x = latitudeInit;
}

-(void)setLongitude:(double)longitudeInit
{
    position.y = longitudeInit;
}

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