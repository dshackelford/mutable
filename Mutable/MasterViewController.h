//
//  MasterViewController.h
//  Mutable
//
//  Created by Dylan Shackelford on 9/15/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController
{
    //SWIMPE GESTURES.
    UISwipeGestureRecognizer* swipeRight;
    UISwipeGestureRecognizer* swipeLeft;
    UISwipeGestureRecognizer* swipeDown;
    UISwipeGestureRecognizer* swipeUp;
    UISwipeGestureRecognizer* doubleSwipeDown;
    
    //TAP GESTURES
    UITapGestureRecognizer* singleTap;
    UITapGestureRecognizer* doubleDoubleTap;
    UILongPressGestureRecognizer* longPress;
    UILongPressGestureRecognizer* doubleLongPress;
    
    UIPanGestureRecognizer* twoFingerTouch;
    UIPinchGestureRecognizer* pinch;

}

-(void)establishGestures;


-(void)longPress: (UILongPressGestureRecognizer *)aLongPress;
-(void)doubleLongPress:(UILongPressGestureRecognizer*)aDoubleLongPress;
-(void)didDoubleTap:(UITapGestureRecognizer*)aDoubleTap;
-(void)didSingleTap:(UITapGestureRecognizer*)aSingleTap;
-(void)didSwipe:(UISwipeGestureRecognizer*)swipe;
-(void)didDoubleSwipe:(UISwipeGestureRecognizer*)aDoubleSwipe;
-(void)didPinch:(UIPinchGestureRecognizer *)aPinch;


//BACKGROUNAD IMAGES
-(UIImageView*)makeGreyBackgroundMenuImage;
-(UIImageView*)makeGreenBackgroundMenuImage;
-(UIImageView*)makeRedBackgroundMenuImage;

@end