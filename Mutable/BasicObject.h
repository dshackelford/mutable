//
//  BasicObject.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "AppFile.h"

@interface BasicObject : NSObject
{
    CGPoint position;
    
    CGSize size;
    
    UIImageView* theImage;
    
    NSString* imageFileName;
}


-(void)initBasicObject:(CGPoint)positionInit :(CGSize)sizeInit :(NSString*)imageFileStringInit;

//-(Vector*)getPosition;
-(double)getLatitude;
-(double)getLongitude;

-(UIImageView*)getImage;
-(void)setImage;

-(void)setSize:(CGSize)sizeInit;
-(void)setSize:(double)xInit :(double)yInit;

-(void)setLatitude:(double)latitudeInit;
-(void)setLongitude:(double)longitudeInit;


-(CGPoint)getPosition;
-(void)setPosition:(CGPoint)pointInit;
-(CGSize)getSize;
-(NSString*)getImageFileName;

@end