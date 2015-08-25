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

NSString* difficultySetting;

double screenHeight;
double screenWidth;

double currentLevel;
double globalSnakeLength;
double snakeVelocity;

BOOL gameStatus;
BOOL shapeShiftBool;
BOOL won;
BOOL restart;

BOOL circle;
BOOL square;
BOOL line;
BOOL triangle;

BOOL notificationDeclared;

NSMutableDictionary* restartDictionary; //used for restarts

NSMutableArray* objectArray;

NSMutableArray* snakeArrayFromConstants;

#define pi = 3.14159;


