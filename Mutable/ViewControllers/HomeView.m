//
//  HomeView.m
//  Mutable
//
//  Created by Dylan Shackelford on 3/23/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeView.h"


@implementation HomeView

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"HomeDirectory: %@",NSHomeDirectory());
    
    //WHAT PHONE ARE WE USING?
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if ([AppUtilities doesFileExistAtPath:[AppUtilities getPathToUserInfoFile]] == NO)
    {
        NSFileManager* appInfo = [NSFileManager defaultManager];
        
        [appInfo createFileAtPath:[AppUtilities getPathToUserInfoFile] contents:nil attributes:nil];
        
        NSArray* keys=@[@"DifficultySetting"];
        
        NSArray* objects=@[@"Easy"];
    
        NSMutableDictionary* myDictionary =[[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
        
        [myDictionary writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES ];
    }
    else //DIFFICULTY SETTING HAS TO BE ESTABLISHED IN HOMEVIEW BECUASE IT HAS TO BE READY FOR SETTINGS IF THE GAME IS NOT PLAYED IMMEDIATELY.
    {
        NSDictionary* myDictionary = [NSDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
        
        if ([myDictionary objectForKey:@"DifficultySetting"] == nil)
        {
            difficultySetting = @"Easy";
        }
        else
        {
            difficultySetting = [myDictionary objectForKey:@"DifficultySetting"];
        }
    }
    
    //MAKE THE ART FOR ALL TYPES OF IPHONE TYPES
    
    HeadLink* homeViewHeadLink = [[HeadLink alloc] init];
    Snake* homeViewSnake = [[Snake alloc] init];
    
    [homeViewHeadLink initHeadLink:CGPointMake(screenWidth - 70, 150) Velocity:CGVectorMake(100, 0) View:self.view PlaceHolder:homeViewPlaceHolderButton];
    
    [homeViewSnake initSnake:400 headLink:homeViewHeadLink container:self.view button:homeViewPlaceHolderButton];
    
    
    //NSMutableArray* homeViewMineArray = [[NSMutableArray alloc] init];
    for( double i = 1; i < 5; i =  i + 1)
    {
        if (screenHeight > 480)
        {
            Mine* aMine1 = [[Mine alloc] initMine:CGPointMake((screenWidth/5)*i, screenHeight - screenHeight/10) :self.view :homeViewPlaceHolderButton];
            
            Mine* aMine2 = [[Mine alloc] initMine:CGPointMake((screenWidth/5)*i, screenHeight - 2*screenHeight/10) :self.view :homeViewPlaceHolderButton];
        }

    }
}





    //DRAWING CONTEXTS PRACTICE
//    
//    UIGraphicsBeginImageContext(CGSizeMake(10,10));
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineWidth(ctx, 1.5);
//
//    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 8, 8));
//    CGContextDrawPath(ctx, kCGPathFillStroke);
//    
//    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    circleView = [[UIImageView alloc] initWithImage:circle];
//    circleView.center = CGPointMake(250,400);
//    [self.view addSubview:circleView];
//    
//    
//    
//    
//
//    UIGraphicsBeginImageContext(CGSizeMake(screenHeight ,screenHeight));
//    CGContextRef screenContext = UIGraphicsGetCurrentContext();
//    
//
//    CGContextSetLineWidth(screenContext, 1);
//    CGContextSetStrokeColorWithColor(screenContext, [UIColor yellowColor].CGColor);
//
//    CGContextAddEllipseInRect(screenContext, CGRectMake(250 ,300, 100, 100));
//    
//
//    CGContextDrawPath(screenContext, kCGPathStroke);
//
//    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//
//    UIImageView *curveView = [[UIImageView alloc] initWithImage:curve];
//
//    curveView.center = CGPointMake(200, 400);
//    curveView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:curveView];
//
//    
//
//  
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//
//    pathAnimation.calculationMode = kCAAnimationPaced;
//
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = NO;
//    pathAnimation.duration = 5.0;
//
//    pathAnimation.repeatCount = 1000;
//
//    CGMutablePathRef curvedPath = CGPathCreateMutable();
//
//    CGPathAddEllipseInRect(curvedPath, NULL, CGRectMake(200, 300, 100, 100));
//    
// 
//    pathAnimation.path = curvedPath;
//    CGPathRelease(curvedPath);
//    
//
//    UIGraphicsBeginImageContext(CGSizeMake(20,20));
//    CGContextRef pathContext = UIGraphicsGetCurrentContext();
//
//    CGContextDrawPath(pathContext, kCGPathFillStroke);
//    UIGraphicsEndImageContext();
//
//    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];


@end