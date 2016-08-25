//
//  LevelController.m
//  Mutable
//
//  Created by Dylan Shackelford on 3/19/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelViewController.h"


@implementation LevelViewController

-(void)viewDidLoad
{
    [self establishGestures];
    
    //NOTIFICATION INITILIZER, LIMITED TO ONLY ONE OBSERVER
    NSLog(@"Level View Did Load");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deathNotifcation:) name:@"DeathNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundActivityNotification:) name:@"BackgroundActivityStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLinksNotification:) name:@"AddLinks" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youWonNotification:) name:@"YouWin" object:nil];
        
    //CREATE OBJECTS FILE IF FILE DOES NOT EXIST
    if ([AppUtilities doesFileExistAtPath:[AppUtilities getPathToLevelObjectsFile]] == NO)
    {
        NSFileManager* levelObjectsFile = [NSFileManager defaultManager];
    
        [levelObjectsFile createFileAtPath:[AppUtilities getPathToLevelObjectsFile] contents:nil attributes:nil];
    }
    
    //GRAB DATA FROM SAVED FILE TO SET UP LEVEL FROM PREVIOUS VERSIONS AND RESTARTS
    if ([AppUtilities doesFileExistAtPath:[AppUtilities getPathToUserInfoFile]] == YES)
    {
        NSMutableDictionary* dictionaryFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
        
        NSString* snakeLengthFromFile = [dictionaryFile objectForKey:@"snakeLength"];
        
        if ([snakeLengthFromFile doubleValue] > 0)
        {
            levelSnakeLength = [snakeLengthFromFile doubleValue] + 25;
        }
        currentLevel = [[dictionaryFile objectForKey:@"currentLevel"] doubleValue];
        
        //currentLevel = 15;
    }
    
    //HIDE BUTTONS
    mainMenuButton.hidden = YES;
    settingsButton.hidden = YES;
    howToPlayButton.hidden = YES;
    keepPlayingButton.hidden = YES;
    placeHolderButton.hidden = YES;
    endLevelLabel.hidden = YES;
    endLevelLabel.numberOfLines = 2;
    restartButton.hidden = YES;
    nextLevelButton.hidden = YES;
    pauseButton.hidden = NO;
    ammoCount.hidden = NO;
    shapeUnlockLabel.hidden = YES;
    
    levelCountLabel.hidden = NO;
    levelCountLabel.text = [NSString stringWithFormat:@"LEVEL: %.f",currentLevel];
    
    //GLOBAL VARIABLES
    lostCounter = 0;
    blockadeCounter = 0;
    droneCounter = 0;
    lifePowerUpCounter = 0;
    shapeShiftBool = NO;
    
    //SET SNAKE LENGTH, OTHERWISE TAKEN CARE OF WITH DATA FROM FILE
    if (currentLevel == 0)
    {
        levelSnakeLength = 50;
    }
    
    initialHeadLatitude = 10;
    initialHeadLongitude = 200;
    initialHeadVelocityX = 200;
    initialHeadVelocityY = 0;
    
    //INITIAL HEADLINK POSITION
    snakeVelocity = initialHeadVelocityX; //just in case user goes into shape shift and does not fire!
    
    //ALLOCATION OF COMMON OBJECT ARRAYS
    
    theViewPopulator = [[ViewPopulator alloc] init];
    [theViewPopulator prepViewPopulator];
    
//    lifePowerUpArray = [[NSMutableArray alloc] init];

    objectArray = [[NSMutableArray alloc] init];
    
    //GO INTO THE LEVEL
    [self placeStaticObjects];
    
    [super viewDidLoad];
}
-(void)viewDidDisappear:(BOOL)animated
{
    //clean up the notification center when the view disappears
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DeathNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BackgroundActivityStarted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddLinks" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"YouWin" object:nil];
    NSLog(@"Level View did disappear");
}

#pragma mark - Notifications

-(void)addLinksNotification:(NSNotification*)notification
{
    NSLog(@"Add links");
    [levelSnake addLinksToSnake:15 headLink:levelHeadLink container:self.view];
}


- (void)deathNotifcation:(NSNotification *) notification
{
    NSLog(@"Death Notification recieved");
    [self youLost];
    
}

-(void)youWonNotification:(NSNotification *) notification
{
    NSLog(@"Won Notification Recieved");
    [self youWon];
}

-(void)backgroundActivityNotification:(NSNotification*)notification
{
    NSLog(@"Pause the timer");
    
    [theTimer invalidate];
    
    pauseButton.hidden = YES;
    mainMenuButton.hidden = NO;
    settingsButton.hidden = NO;
    howToPlayButton.hidden = NO;
    keepPlayingButton.hidden = NO;
    endLevelLabel.hidden = NO;
    endLevelLabel.text = [NSString stringWithFormat:@"PAUSED"];
    ammoCount.hidden = YES;
    levelCountLabel.hidden = YES;
    shapeUnlockLabel.hidden = YES;
    
    
    backgroundImage = [self makeGreyBackgroundMenuImage];
    
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
}


#pragma mark - Level View

-(void)placeStaticObjects //make the static objects here
{
    gameStatus = YES;
    
    //HINTS FOR SHAPE SHIFT NOTIFICATIONS
    if (currentLevel == 6)
    {
        shapeUnlockLabel.hidden = NO;
        shapeUnlockLabel.text = @"LINE UNLOCKED";
    }
    if (currentLevel == 8)
    {
        shapeUnlockLabel.hidden = NO;
        shapeUnlockLabel.text = @"SQUARE UNLOCKED";
    }
    if (currentLevel == 13)
    {
        shapeUnlockLabel.hidden = NO;
        shapeUnlockLabel.text = @"TRIANGLE UNLOCKED";
    }
    
    
    if (restart == NO) //A NORMAL START OF THE GAME FROM MAIN MENU
    {
        //MAKE HEADLINK
        levelHeadLink = [[HeadLink alloc] initHeadLink:CGPointMake(initialHeadLatitude, initialHeadLongitude) Velocity:CGVectorMake(initialHeadVelocityX, initialHeadVelocityY) View:self.view PlaceHolder:placeHolderButton];
        
        //MAKE SNAKE
        levelSnake = [[Snake alloc] initSnake:levelSnakeLength headLink:levelHeadLink container:self.view button:placeHolderButton];
        
        //ENEMY BASE
        levelEnemyBase = [[Base alloc] initBase:levelHeadLink :5 :self.view :placeHolderButton locationOverRide: NO Position:CGPointMake(0, 0)];
        
        //LEVEL GEM
        levelGem = [[Gem alloc] initGem:[levelEnemyBase getPosition] :self.view :[levelEnemyBase getHealthBarImage]];
        
        //MINE FIELD - adding the array gained from mine field class
        if (currentLevel > 0)
        {
            [MineField makeRandomMineField:levelEnemyBase headLink:levelHeadLink container:self.view placeholder:placeHolderButton];
        }
        
        //BUILD A Mine BARRACADE
        if (currentLevel > 5 && currentLevel < 10)
        {
            [MineField makeMineBarracade:levelEnemyBase container:self.view placeHolder:placeHolderButton];
        }
        
        //MAKE TURRET GUN
        if (currentLevel > 12)
        {
        levelTurretGun = [[TurretGun alloc] initTurretGun:levelHeadLink Base:levelEnemyBase LocationOverRide:NO Position:CGPointMake(0, 0) Velocity:CGVectorMake(0, 0) View:self.view PlaceHolder:placeHolderButton];
        }
        
        [BlockadeBarricade createBlockadeBarricade:levelEnemyBase View:self.view PlaceHolder:placeHolderButton];
        
        
        //SAVE THE INITAL MAP LAYOUT TO FILE FOR POTENTIAL RESTART
        [AppUtilities saveLevelForRestart];
    }
    else //IF I DO RESTART A LEVEL, I WANT IT TO LOOK THE SAME AS WHEN I STARTED
    {
        restart = NO;
        
        [AppUtilities getObjectsForLevelRestart:self.view :placeHolderButton];
        
        //I ADD OBJECTS FROM RESTART DICTIONARY TO A NEW OBJECT ARRAY.
        for (id object in objectArray)
        {
            if ([[NSString stringWithFormat:@"%@",[object class]] isEqualToString:@"HeadLink"])
            {
                levelHeadLink = object;
                [levelHeadLink setVelocity:CGVectorMake(snakeVelocity, 0)];
                break;
            }
            if([[NSString stringWithFormat:@"%@",[object class]] isEqualToString:@"Base"])
            {
                levelEnemyBase = object;
            }
            if([[NSString stringWithFormat:@"%@",[object class]] isEqualToString:@"TurretGun"])
            {
                levelTurretGun = object;
            }
        }
        
        //MAKE SNAKE
        levelSnake = [[Snake alloc] initSnake:levelSnakeLength headLink:levelHeadLink container:self.view button:placeHolderButton];
     }
    
    
    //START FRAME RATE
    theTimer = [NSTimer scheduledTimerWithTimeInterval:deltaTime target:self selector:@selector(updateMovement) userInfo:nil repeats:YES];
    

    currentLevelLabelCounter = 0;
    turretGunCounter = 0;
    bigBulletCounter = 0;
}

#pragma mark - Update Movement

-(void)updateMovement //make the moving objects here
{
    //HIDING/SHOWING CURRENT LEVEL LABEL ON SCREEN TO REMIND USER
    currentLevelLabelCounter = currentLevelLabelCounter + 1;
    if (currentLevelLabelCounter > 200)
    {
        currentLevelLabelCounter = 0;
        levelCountLabel.hidden = YES;
        shapeUnlockLabel.hidden = YES;
    }

    if (line == NO)
    {
        if (currentLevel > 4)
        {
            [Shifting shiftMineField];
        }
    }
    if (line == YES)
    {
        [Shifting showMineField];
    }
    
    globalSnakeLength = [[levelSnake getSnakeArray] count]; //I use globalSnakeLength to talk to headlink shape shift radius
    
    //move the moving objects
    for (int i = 0; i < [objectArray count]; i = i + 1)
    {
        id object = [objectArray objectAtIndex:i];
        
        [object move:levelHeadLink];
    }
    
    [theViewPopulator populateView:levelHeadLink Base:levelEnemyBase TurretGun:levelTurretGun View:self.view PlaceHolder:placeHolderButton];
    
    
    //AMMO COUNT
    if ([[levelSnake getSnakeArray] count] < 11)
    {
        ammoCount.textColor = [UIColor redColor];
    }
    else
    {
        ammoCount.textColor = [UIColor whiteColor];
    }
    
    ammoCount.text = [NSString stringWithFormat:@"%.f",(double)[[levelSnake getSnakeArray] count]];
    
    
    //BASE HEALTH REGENERATION
    if ([levelEnemyBase getEnemyBaseHealth] < [levelEnemyBase getBaseHealthCap] && [levelEnemyBase getRegeneration] == YES)
    {
        healthRegenerationCounter = healthRegenerationCounter + 1;
        
        if (healthRegenerationCounter > 200)
        {
            [levelEnemyBase addHealth:self.view :placeHolderButton];
            healthRegenerationCounter = 0;
        }
    }
}

-(void)detectCollision
{
    for (id object in objectArray)
    {
        for (id object2 in objectArray)
        {
            if (fabs([object getPosition].x - [object2 getPosition].x) < [object getSize].width && fabs([object getPosition].y - [object2 getPosition].y) < [object getSize].height)
            {
                if ([object class] == [Bullet class] || [object2 class] == [Bullet class])
                {
                     
                }
                
                if ( [object class] == [HeadLink class] || [object2 class] == [HeadLink class])
                {
                    
                }
            }
        }
    }
}

#pragma mark - Game Checkers


-(BOOL)checkShapeShiftStatus
{
    return shapeShiftBool;
}

#pragma mark - Winners and Losers

-(void)youWon
{
    [theTimer invalidate];
    
    //REMOVE IMAGES FROM SCREEN
    for (id object in objectArray)
    {
        [[object getImage] removeFromSuperview];
    }
    
    [objectArray removeAllObjects];
    
    //SAVE LEVEL STATUS AND INFO
    NSString* levelString = [NSString stringWithFormat: @"%.f",currentLevel + 1];
    
    NSMutableDictionary* dictionaryFromFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToUserInfoFile]];
    
    [dictionaryFromFile setObject:levelString forKey:@"currentLevel"];

    [dictionaryFromFile setObject:[NSString stringWithFormat:@"%.f",(double)[[levelSnake getSnakeArray] count]] forKey:@"snakeLength"];
    
    [dictionaryFromFile writeToFile:[AppUtilities getPathToUserInfoFile] atomically:YES ];
    
    won = NO;
    
    backgroundImage = [self makeGreenBackgroundMenuImage];
    
    pauseButton.hidden = YES;
    
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
    
    endLevelLabel.text = [NSString stringWithFormat:@"YOU BEAT LEVEL %.f!",currentLevel];
    //currentLevel = currentLevel + 1;
    endLevelLabel.hidden = NO;
    ammoCount.hidden = YES;
    pauseButton.hidden = YES;
    levelCountLabel.hidden = YES;
    
    [[levelGem getImage] removeFromSuperview];
    
    endLevelTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(delayWonResponse) userInfo:nil repeats:YES];
}


-(void)delayWonResponse
{
    lostCounter = lostCounter + 1;
    
    if (lostCounter == 2)
    {
        nextLevelButton.hidden = NO;
    }
    if (lostCounter == 3)
    {
        mainMenuButton.hidden = NO;
    }
    if (lostCounter == 4)
    {
        settingsButton.hidden = NO;
    }
    if (lostCounter == 5)
    {
        howToPlayButton.hidden = NO;
        [endLevelTimer invalidate];
    }
}


-(void)youLost
{
    [theTimer invalidate];
    
    //REMOVE IMAGES FROM SCREEN
    for (id object in objectArray)
    {
        [[object getImage] removeFromSuperview];
    }
    
    [objectArray removeAllObjects];

    //INSERT BACKGROUND IMAGE
    backgroundImage = [self makeRedBackgroundMenuImage];
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
    
    endLevelLabel.text = [NSString stringWithFormat:@"DIED ON LEVEL %.f",currentLevel];
    endLevelLabel.hidden = NO;
    pauseButton.hidden = YES;
    ammoCount.hidden = YES;
    levelCountLabel.hidden = YES;
    shapeUnlockLabel.hidden = YES;
    
    triangle = NO;
    square = NO;
    circle = NO;
    line = NO;
    
    endLevelTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(delayLostResponse) userInfo:nil repeats:YES];
    
}

-(void)delayLostResponse
{
    lostCounter = lostCounter + 1;
    
    if (lostCounter == 2)
    {
        restartButton.hidden = NO;
    }
    
    if (lostCounter == 3)
    {
        mainMenuButton.hidden = NO;
    }
    if (lostCounter == 4)
    {
        settingsButton.hidden = NO;
    }
    if (lostCounter == 5)
    {
        howToPlayButton.hidden = NO;
        [endLevelTimer invalidate];
    }
}


#pragma mark - UI Gestures

-(void)longPress: (UILongPressGestureRecognizer *)aLongPress
{
    if (aLongPress.state == UIGestureRecognizerStateBegan)
    {
        if (shapeShiftBool == NO)
        {
            shapeShiftBool = YES;
            
            circle = YES;
            
            //DETEMINE THE SHAPE RADIUS TO ALLOW THE CENTER TO BE FOUND LATER
            [levelHeadLink setShapeRadius: [[levelSnake getSnakeArray] count]/(2*M_PI)];
            
            //DETERMINE CENTER POINT FOR ROTATION
            if ([levelHeadLink getVelocity].dx < 0)
            {
                [levelHeadLink setShapeCenter: CGPointMake([levelHeadLink getPosition].x, [levelHeadLink getPosition].y - [levelHeadLink getShapeRadius])];
            }
            
            if ([levelHeadLink getVelocity].dx > 0)
            {
                [levelHeadLink setShapeCenter: CGPointMake([levelHeadLink getPosition].x, [levelHeadLink getPosition].y + [levelHeadLink getShapeRadius])];
            }
            
            if ([levelHeadLink getVelocity].dy < 0)
            {
                
                [levelHeadLink setShapeCenter: CGPointMake([levelHeadLink getPosition].x + [levelHeadLink getShapeRadius], [levelHeadLink getPosition].y)];
            }
            
            if ([levelHeadLink getVelocity].dy > 0)
            {
                [levelHeadLink setShapeCenter: CGPointMake([levelHeadLink getPosition].x - [levelHeadLink getShapeRadius], [levelHeadLink getPosition].y)];
            }
            
        }
        
        if (square == YES)
        {
           bigBulletTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(bigBulletCounter) userInfo:nil repeats:YES];
        }
        
//        if (triangle == YES)
//        {
//            ammoCount.backgroundColor = [UIColor greenColor];
//            [MovingWall createTheWall:levelHeadLink View:self.view];
//        }
        
    }
    
    if (aLongPress.state == UIGestureRecognizerStateEnded)
    {
        
        [bigBulletTimer invalidate];
        
        if (square == YES)
        {
            CGPoint touchTarget = [aLongPress locationInView:self.view];
            
            //MAKE A BIG BULLET
            CGSize bulletSize = CGSizeMake(bigBulletCounter, bigBulletCounter);
            
            Bullet* newBullet = [[Bullet alloc] initBullet:touchTarget InitialPosition:[levelHeadLink getShapeCenter] Size:bulletSize Container:self.view PlaceHolder:placeHolderButton];
            
            [newBullet setSize:bulletSize];
            
            bigBulletCounter = 0;
            
        }
        
        if (triangle == YES)
        {
            ammoCount.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.45];
        }
    }
    
    if (triangle == YES)
    {
        if ([[levelSnake getSnakeArray] count] > 0)
        {
            CGPoint location = [aLongPress locationInView:self.view];
            
            [[Bullet alloc] initBullet:location InitialPosition:location Size:CGSizeMake(10, 10) Container:self.view PlaceHolder:placeHolderButton];
            
            [levelSnake removeHowManyLinksFromSnake:1];
        }
    }
}


-(void)bigBulletCounter
{
    bigBulletCounter = bigBulletCounter + 1;
    
    if ((int)bigBulletCounter % 15 == 0)
    {
        [levelSnake removeHowManyLinksFromSnake:1];
    }
}

-(void)doubleLongPress:(UILongPressGestureRecognizer*)aDoubleLongPress
{
    if (aDoubleLongPress.state == UIGestureRecognizerStateBegan)
    {
        if (shapeShiftBool == NO && currentLevel > 12)
        {
            shapeShiftBool = YES;
            triangle = YES;
        }

    }
}


-(void)didDoubleTap:(UITapGestureRecognizer*)aDoubleTap //double tap with two fingers
{
    if (shapeShiftBool == NO && currentLevel > 7)
    {
        shapeShiftBool = YES;
        square = YES;
    }
}


-(void)didSingleTap:(UITapGestureRecognizer*)aSingleTap
{
    if (shapeShiftBool == YES)
    {
        if ([[levelSnake getSnakeArray] count] > 0 && line == NO)
        {
            CGPoint touchTarget = [aSingleTap locationInView:self.view];
            
            if (circle == YES || line == YES || triangle == YES)
            {
                CGSize bulletSize = CGSizeMake(10, 10);
                
                [[Bullet alloc] initBullet:touchTarget InitialPosition:[levelHeadLink getShapeCenter] Size:bulletSize Container:self.view PlaceHolder: placeHolderButton];
            }
            
            if (square == YES)
            {
                
                DoubleBullet* aDoubleBullet = [[DoubleBullet alloc] init];
            
                [aDoubleBullet createDoubleBullet:levelHeadLink container:self.view placeHolder:placeHolderButton Target:touchTarget];
        
            }
            
            [levelSnake removeHowManyLinksFromSnake:1];
        }
    }
    
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{
    //NO SHAPE SHIFTING
    shapeShiftBool = NO;
    
    circle = NO;
    square = NO;
    line = NO;
    triangle = NO;
    
    [levelHeadLink resetShapeCounter];
    
    //TELL HEADLINK HOW FAST & WHAT DIRECTION
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [levelHeadLink setVelocity:CGVectorMake(snakeVelocity, 0)];
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        
        [levelHeadLink setVelocity:CGVectorMake(-snakeVelocity, 0)];

    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown)
    {
        
        [levelHeadLink setVelocity:CGVectorMake(0, snakeVelocity)];

    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        
        [levelHeadLink setVelocity:CGVectorMake(0, -snakeVelocity)];
    }
}


-(void)didDoubleSwipe:(UISwipeGestureRecognizer*)aDoubleSwipe
{
    BOOL wallCollect = NO;
    
    if ([wallArray count] > 0)
    {
        for (BasicObject* aLink in wallArray)
        {
            //GRAB WALL LINKS AND ADD TO SNAKE IF WITHIN RANGE
            if (fabs([levelHeadLink getPosition].x - [aLink getPosition].x) < 50 && fabs([levelHeadLink getPosition].y - [aLink getPosition].y) < 50)
            {
                wallCollect = YES;
                break;
            }
        }
    }
    
    if (wallCollect == NO)
    {
        [levelSnake removeHowManyLinksFromSnake:[[levelSnake getSnakeArray] count]/2];
    }
    else
    {
        [levelSnake addLinksToSnake:[wallArray count] headLink:levelHeadLink container:self.view];
        
        for (int i = 0; i < [wallArray count]; i = i + 1)
        {
            UIImageView* aLinkImage = [[wallArray objectAtIndex:i] getImage];
            [aLinkImage removeFromSuperview];
        }
        
        [wallArray removeAllObjects];
        
        wallCollect = NO;
    }
    
}


-(void)didPinch:(UIPinchGestureRecognizer *)aPinch
{
    
    if (shapeShiftBool == NO && currentLevel > 5)
    {
        shapeShiftBool = YES;
        line = YES;
    }

}


#pragma mark - Buttons

-(IBAction)didPressPauseButton:(id)sender
{
    [theTimer invalidate];
    
    pauseButton.hidden = YES;
    mainMenuButton.hidden = NO;
    settingsButton.hidden = NO;
    howToPlayButton.hidden = NO;
    keepPlayingButton.hidden = NO;
    endLevelLabel.hidden = NO;
    endLevelLabel.text = [NSString stringWithFormat:@"PAUSED"];
    ammoCount.hidden = YES;
    levelCountLabel.hidden = YES;
    shapeUnlockLabel.hidden = YES;
    
    
    backgroundImage = [self makeGreyBackgroundMenuImage];
    
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
}

-(IBAction)didPressKeepPlaying:(id)sender
{
    theTimer = [NSTimer scheduledTimerWithTimeInterval:deltaTime target:self selector:@selector(updateMovement) userInfo:nil repeats:YES];
    
    pauseButton.hidden = NO;
    mainMenuButton.hidden = YES;
    settingsButton.hidden = YES;
    howToPlayButton.hidden = YES;
    keepPlayingButton.hidden = YES;
    endLevelLabel.hidden = YES;
    ammoCount.hidden = NO;
    
    [backgroundImage removeFromSuperview];
}

-(IBAction)didPressMainMenu:(id)sender
{
    [theTimer invalidate];
    
    //REMOVE IMAGES FROM SCREEN
    for (id object in objectArray)
    {
        [[object getImage] removeFromSuperview];
    }
    
    [objectArray removeAllObjects];
}


-(IBAction)didPressHowToPlay:(id)sender
{
    [theTimer invalidate];
}

-(IBAction)didPressSettings:(id)sender
{
    globalSnakeLength  = [levelSnake getSnakeLength];
    [theTimer invalidate];
}

-(IBAction)didPressNextLevel:(id)sender
{
  
}

-(IBAction)didPressRestartButton:(id)sender
{
    restart = YES;
    NSLog(@"%f",currentLevel);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end