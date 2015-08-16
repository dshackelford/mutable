//
//  MovingObject.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/19/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//


#import "BasicObject.h"

@interface MovingObject : BasicObject
{
//    double velocityX;
//    double velocityY;
    
    CGVector velocity;
    
    CGPoint shapeCenter;
    
    double shapeRadius;
    
    BOOL bounded;
    
    int boundraryCondition;
    
    double shapeCounter;
}

-(void)initMovingObject:(CGPoint)positionInit :(CGVector)velocityInit :(CGSize)sizeInit :(NSString*)imageFileString;

-(void)move;
-(void)moveInCircle;
-(void)moveInSquare;
-(void)moveInLine;
-(void)moveInTriangle;

-(CGVector)getVelocity;
-(CGPoint)getShapeCenter;
-(double)getShapeRadius;
-(void)resetShapeCounter;


-(void)setVelocity:(CGVector)velocityVectorInit;

-(void)setShapeCenter:(CGPoint)shapeCenterInit;
-(void)setShapeRadius:(double)shapeRadiusInit;


@end