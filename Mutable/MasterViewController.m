//
//  MasterViewController.m
//  Mutable
//
//  Created by Dylan Shackelford on 9/15/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterViewController.h"
#import "AppConstants.h"

@implementation MasterViewController

-(void)establishGestures
{
    
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    
    doubleDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleDoubleTap.numberOfTapsRequired = 2;
    doubleDoubleTap.numberOfTouchesRequired = 2;
    
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    doubleSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleSwipe:)];
    doubleSwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    doubleSwipeDown.numberOfTouchesRequired = 2;
    
    
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = 0.25;
    
    doubleLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doubleLongPress:)];
    doubleLongPress.numberOfTouchesRequired = 2;
    
    
    pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
    [pinch requireGestureRecognizerToFail:doubleSwipeDown];
    
    [self.view addGestureRecognizer:singleTap];
    [self.view addGestureRecognizer:longPress];
    [self.view addGestureRecognizer:doubleDoubleTap];
    [self.view addGestureRecognizer:swipeUp];
    [self.view addGestureRecognizer:swipeDown];
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:doubleLongPress];
    [self.view addGestureRecognizer:pinch];
    [self.view addGestureRecognizer:doubleSwipeDown];
}


-(void)longPress: (UILongPressGestureRecognizer *)aLongPress
{

}

-(void)doubleLongPress:(UILongPressGestureRecognizer*)aDoubleLongPress
{

}

-(void)didDoubleTap:(UITapGestureRecognizer*)aDoubleTap
{

}

-(void)didSingleTap:(UITapGestureRecognizer*)aSingleTap
{

}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{

}

-(void)didDoubleSwipe:(UISwipeGestureRecognizer*)aDoubleSwipe
{

}

-(void)didPinch:(UIPinchGestureRecognizer *)aPinch
{

}


-(UIImageView*)makeGreyBackgroundMenuImage
{
    CGRect backgroundMenuFrame = CGRectMake(0, 0, screenWidth, screenHeight);
    UIImageView* backgroundMenuImage = [[UIImageView alloc] initWithFrame:backgroundMenuFrame];
    backgroundMenuImage.image = [UIImage imageNamed:@"greyBackground.png"];
    return backgroundMenuImage;
}

-(UIImageView*)makeGreenBackgroundMenuImage
{
    CGRect greenBackgroundFrame = CGRectMake(0, 0, screenWidth, screenHeight);
    UIImageView* aGreenBackgroundImage = [[UIImageView alloc] initWithFrame:greenBackgroundFrame];
    aGreenBackgroundImage.image = [UIImage imageNamed:@"GreenBackgroundMenu.png"];
    return aGreenBackgroundImage;
}

-(UIImageView*)makeRedBackgroundMenuImage
{
    CGRect redBackgroundFrame = CGRectMake(0, 0, screenWidth, screenHeight);
    UIImageView* aRedBackgroundImage = [[UIImageView alloc] initWithFrame:redBackgroundFrame];
    aRedBackgroundImage.image = [UIImage imageNamed:@"redBackground.png"];
    return aRedBackgroundImage;
}



@end