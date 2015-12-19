//
//  BasicObject.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/22/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "AppUtilities.h"



@interface BasicObject : NSObject
{
    CGPoint position;
    
    CGSize size;
    
    UIImageView* theImage;
    
    NSString* imageFileName;
}


-(id)initBasicObject:(CGPoint)positionInit :(CGSize)sizeInit :(NSString*)imageFileStringInit;
-(id)initRestart:(CGPoint)positionInit Container:(UIView*)container Placeholder:(UIButton*)placeHolderButtonInit Velocity:(CGVector)velocityInit;


-(void)move;
-(void)move:(id)objectTracker;

-(void)hit;
-(void)crash;
-(void)hide;
-(void)show;


-(CGPoint)getPosition;
-(UIImageView*)getImage;
-(CGSize)getSize;
-(NSString*)getImageFileName;


-(void)setPosition:(CGPoint)pointInit;
-(void)setImage;
-(void)setSize:(CGSize)sizeInit;
-(void)setSize:(double)xInit :(double)yInit;


@end