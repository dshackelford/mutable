//
//  LevelController.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/19/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "AppUtilities.h"

#import "BasicObject.h"
#import "Base.h"
#import "Gem.h"
#import "Food.h"
#import "Mine.h"
#import "MineField.h"
#import "Shifting.h"
#import "TurretGun.h"

#import "MovingObject.h"
#import "HeadLink.h"
#import "Snake.h"
#import "Bullet.h"
#import "BlockadeElement.h"
#import "Barracade.h"
#import "Arrow.h"
#import "Drone.h"
//#import "Squadron.h"
#import "DoubleBullet.h"
#import "BlockadeBarricade.h"
#import "WallLink.h"
#import "MovingWall.h"

#import "MasterViewController.h"
#import "ViewPopulator.h"

#import "Mutable-Swift.h"

@interface LevelViewController : MasterViewController
{
    //OBJECTS [should only be one of a kind]
    Snake* levelSnake;
    MineField* levelMineField;
    Base* levelEnemyBase;
    HeadLink* levelHeadLink;
    Gem* levelGem;
    TurretGun* levelTurretGun;
    ViewPopulator* theViewPopulator;
    
    double initialHeadLatitude;
    double initialHeadLongitude;
    double initialHeadVelocityX;
    double initialHeadVelocityY;
    
    double levelSnakeLength;
    
    NSTimer* endLevelTimer;
    NSTimer* theTimer;
    NSTimer* bigBulletTimer;
    
    //OBJECT ARRAYS
    NSMutableArray* mineArray;
    NSMutableArray* lifePowerUpArray;

    NSMutableArray* blockadeBarricadeArray;
    NSMutableArray* wallArray;

    BOOL didBulletHit;
    BOOL regeneration;
    BOOL turretHit;
    
    //MENU BUTTONS
    IBOutlet UIButton* howToPlayButton;
    IBOutlet UIButton* pauseButton;
    IBOutlet UIButton* mainMenuButton;
    IBOutlet UIButton* settingsButton;

    //PROCEDURAL BUTTONS
    IBOutlet UIButton* placeHolderButton;
    IBOutlet UIButton* gameActionButton;
   
    //LABELS
    IBOutlet UILabel* ammoCount;
    IBOutlet UILabel* endLevelLabel;
    IBOutlet UILabel* levelCountLabel;
    IBOutlet UILabel* shapeUnlockLabel;
    
    UIImageView* backgroundImage;
    
    //COUNTERS
    double blockadeCounter;
    double lostCounter;
    double shiftCounter;
    double droneCounter;
    double healthCounter;
    double lifePowerUpCounter;
    double currentLevelLabelCounter;
    double turretGunCounter;
    double bigBulletCounter;
    double healthRegenerationCounter;
    
    BOOL paused;
}

-(void)placeStaticObjects;
//ESTABLISHERS
-(void)establishGestures:(UIView*)container;

//MOVING OBJECTS
-(void)moveBullet;
-(void)updateMovement;


-(void)checkBaseHealth:(BOOL)regeneration;
-(void)checkGameStatus;

//WINNERS AND LOSERS
-(void)youLost;
-(void)delayLostResponse;
-(void)youWon;
-(void)delayWonResponse;

//BUTTON ACTIONS
-(IBAction)didPressPauseButton:(id)sender;
-(IBAction)didPressKeepPlaying:(id)sender;
-(IBAction)didPressMainMenu:(id)sender;
-(IBAction)didPressSettings:(id)sender;
-(IBAction)didPressHowToPlay:(id)sender;
-(IBAction)didPressNextLevel:(id)sender;
-(IBAction)didPressRestartButton:(id)sender;
-(IBAction)didPressCirlcShapeShiftButton:(id)sender;

-(IBAction)didPressGameActionButton:(id)sender;

//GESTURE ACTIONS
//-(void)didTwoFingerTouch:(UIPanGestureRecognizer*)aTwoFingerTouch;





@end
