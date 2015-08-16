//
//  AppConstants.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/21/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

static double deltaTime = 0.01;


NSString* iphoneType;
NSString* userName;

double screenHeight;
double screenWidth;

double currentLevel;
double globalSnakeLength;
double snakeVelocity;

BOOL gameStatus;
BOOL shapeShiftBool;
BOOL won;
BOOL restart;

//static double kamikazeCount;

BOOL circle;
BOOL square;
BOOL line;
BOOL triangle;
//double shapeCounter;


NSMutableDictionary* restartDictionary; //used for restarts

NSMutableArray* staticObjectArray;
NSMutableArray* dynamicObjectArray;
NSMutableArray* snakeArrayFromConstants;

#define pi = 3.14159;


