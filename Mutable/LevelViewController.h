//
//  LevelController.h
//  Mutable
//
//  Created by Dylan Shackelford on 3/19/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

#import "MovingObject.h"
#import "Bullet.h"
#import "Snake.h"
#import "MineField.h"
#import "Base.h"
#import "BlockadeElement.h"
#import "Kamikaze.h"
#import "HeadLink.h"

#import "Mine.h"
#import "Gem.h"
#import "Barrack.h"
#import "TurretGun.h"
#import "Squadron.h"
#import "DoubleBullet.h"
#import "Arrow.h"
#import "Barracade.h"
#import "Food.h"
#import "Shifting.h"

#import "AppFile.h"


@interface LevelViewController : UIViewController
{
    //OBJECTS [should only be one of a kind]
    Snake* levelSnake;
    MineField* levelMineField;
    Base* levelEnemyBase;
    Barrack* levelBarrack;
    HeadLink* levelHeadLink;
    Gem* levelGem;
    TurretGun* levelTurretGun;
    
    double initialHeadLatitude;
    double initialHeadLongitude;
    double initialHeadVelocityX;
    double initialHeadVelocityY;
    
    double levelSnakeLength;
    
    NSTimer* endLevelTimer;
    NSTimer* theTimer;
    NSTimer* bigBulletTimer;
    
    //OBJECT ARRAYS
    NSMutableArray* bulletArray;
    NSMutableArray* kamikazeArray;
    NSMutableArray* blockadeArray;
    NSMutableArray* mineFieldLevelArray;
    NSMutableArray* shiftingMineFieldArray;
    NSMutableArray* mineArray;
    NSMutableArray* lifePowerUpArray;
    
    NSMutableArray* turretBulletArray;
    NSMutableArray* projectileArray;
    NSMutableArray* blockadeBarricadeArray;
    NSMutableArray* wallArray;
    
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

    BOOL didBulletHit;
    BOOL regeneration;
    BOOL turretHit;
    
    IBOutlet UIButton* howToPlayButton;
    IBOutlet UIButton* pauseButton;
    IBOutlet UIButton* mainMenuButton;
    IBOutlet UIButton* settingsButton;

    IBOutlet UIButton* placeHolderButton;
    IBOutlet UIButton* keepPlayingButton;
    IBOutlet UIButton* nextLevelButton;
    IBOutlet UIButton* restartButton;
    
    IBOutlet UIButton* circlShapeButton;
   
    IBOutlet UILabel* ammoCount;
    IBOutlet UILabel* endLevelLabel;
    IBOutlet UILabel* levelCountLabel;
    IBOutlet UILabel* shapeUnlockLabel;
    
    UIImageView* backgroundImage;
    
    //--------------------------

    NSMutableArray* positionsForMineFieldArray;
    
    //COUNTERS
    double blockadeCounter;
    double lostCounter;
    double shiftCounter;
    double kamikazeCounter;
    double healthCounter;
    double lifePowerUpCounter;
    double currentLevelLabelCounter;
    double turretGunCounter;
    double bigBulletCounter;
    double healthRegenerationCounter;
}

-(void)placeStaticObjects;
//ESTABLISHERS
-(void)establishGestures:(UIView*)container;

//MOVING OBJECTS
-(void)moveBullet;
-(void)updateMovement;

//BACKGROUNAD IMAGES
-(UIImageView*)makeGreyBackgroundMenuImage;
-(UIImageView*)makeGreenBackgroundMenuImage;
-(UIImageView*)makeRedBackgroundMenuImage;

-(void)checkBaseHealth:(BOOL)regeneration;
-(void)checkGameStatus;

//WINNERS AND LOSERS
-(void)youLost:(NSString*)reasonStringInit;
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

//GESTURE ACTIONS
//-(void)didTwoFingerTouch:(UIPanGestureRecognizer*)aTwoFingerTouch;





@end