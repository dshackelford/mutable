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
    CGVector velocity;
    
    CGPoint shapeCenter;
    
    double shapeRadius;
    
    int boundraryCondition;
    
    double shapeCounter;
}

-(id)initMovingObject:(CGPoint)positionInit :(CGVector)velocityInit :(CGSize)sizeInit :(NSString*)imageFileString;

-(void)move;
-(void)move:(id)objectTracker;
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