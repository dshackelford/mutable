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
    //ESTABLISH GESTURES
    [self establishGestures:self.view];
    
    //CREATE OBJECTS FILE IF FILE DOES NOT EXIST
    if ([AppFile doesFileExistAtPath:[AppFile getPathToLevelObjectsFile]] == NO)
    {
        NSFileManager* levelObjectsFile = [NSFileManager defaultManager];
    
        [levelObjectsFile createFileAtPath:[AppFile getPathToLevelObjectsFile] contents:nil attributes:nil];
    }
    
    //GRAB DATA FROM SAVED FILE TO SET UP LEVEL FROM PREVIOUS VERSIONS AND RESTARTS
    if ([AppFile doesFileExistAtPath:[AppFile getPathToUserInfoFile]] == YES)
    {
        NSMutableDictionary* dictionaryFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppFile getPathToUserInfoFile]];
        
        NSString* snakeLengthFromFile = [dictionaryFile objectForKey:@"snakeLength"];
        
        if ([snakeLengthFromFile doubleValue] > 0)
        {
            levelSnakeLength = [snakeLengthFromFile doubleValue] + 25;
        }
        
        currentLevel = [[dictionaryFile objectForKey:@"currentLevel"] doubleValue];
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
    kamikazeCounter = 0;
    lifePowerUpCounter = 0;
    shapeShiftBool = NO;
    
    //SET SNAKE LENGTH, OTHERWISE TAKEN CARE OF WITH DATA FROM FILE
    if (currentLevel == 0)
    {
        levelSnakeLength = 50;
    }
    
    //INITIAL HEADLINK POSITION
    initialHeadLatitude = 10;
    initialHeadLongitude = 200;
    initialHeadVelocityX = 200;
    initialHeadVelocityY = 0;
    snakeVelocity = initialHeadVelocityX; //just in case user goes into shape shift and does not fire!
    
    //ALLOCATION OF COMMON OBJECTS
    levelHeadLink = [[HeadLink alloc] init];
    levelSnake = [[Snake alloc] init];
    levelMineField = [[MineField alloc] init];
    levelEnemyBase = [[Base alloc] init];
    levelGem = [[Gem alloc] init];
    levelBarrack = [[Barrack alloc] init];
    levelTurretGun = [[TurretGun alloc] init];
    levelHeadLink = [[HeadLink alloc] init];
    
    //ALLOCATION OF COMMON OBJECT ARRAYS
    blockadeArray = [[NSMutableArray alloc] init];
    kamikazeArray = [[NSMutableArray alloc] init];
    bulletArray = [[NSMutableArray alloc] init];
    mineFieldLevelArray = [[NSMutableArray alloc] init];
    positionsForMineFieldArray = [[NSMutableArray alloc] init];
    lifePowerUpArray = [[NSMutableArray alloc] init];
    mineArray = [[NSMutableArray alloc] init];
    turretBulletArray = [[NSMutableArray alloc] init];
    projectileArray = [[NSMutableArray alloc] init];
    wallArray = [[NSMutableArray alloc] init];
    
    [projectileArray addObject:turretBulletArray];
    [projectileArray addObject:bulletArray];
    
    [dynamicObjectArray removeAllObjects];
    [staticObjectArray removeAllObjects];
    dynamicObjectArray = [[NSMutableArray alloc] init];
    staticObjectArray = [[NSMutableArray alloc] init];
    snakeArrayFromConstants = [[NSMutableArray alloc] init];
    
    //GO INTO THE LEVEL
    [self placeStaticObjects];
    
    [super viewDidLoad];
}

#pragma mark - Level View

-(void)placeStaticObjects //make the static objects here
{
    gameStatus = YES;
    
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
    
    //MAKE HEADLINK
    [levelHeadLink initHeadLink:CGPointMake(initialHeadLatitude, initialHeadLongitude) Velocity:CGVectorMake(initialHeadVelocityX, initialHeadVelocityY) View:self.view PlaceHolder:placeHolderButton];
    
    //MAKE SNAKE
    [levelSnake initSnake:levelSnakeLength headLink:levelHeadLink container:self.view button:placeHolderButton];

    
    //IF RESTART, THEN WE NEED TO GRABE THE MINEFIELD FROM THE FILE AND ADD IT TO THE MINE ARRAY
    if (restart == YES)
    {
        restart = NO;
        
        NSMutableDictionary* levelObjectsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppFile getPathToLevelObjectsFile]];
        
        NSMutableDictionary* mineFielDictionary = [levelObjectsDictionary objectForKey:@"MineFieldDictionary"];
        
        //DIVIDE DICTIONARY BY TWO BECASUE THERE X & Y FOR EVERY ONE COUNT
        for (int i = 0; i < [mineFielDictionary count]/2; i = i + 1)
        {
            
            double x = [[mineFielDictionary objectForKey:[NSString stringWithFormat:@"MineX%.d",i]] doubleValue];
            double y = [[mineFielDictionary objectForKey:[NSString stringWithFormat:@"MineY%.d",i]] doubleValue];
            
            Mine* aMine = [[Mine alloc] initMine:CGPointMake(x, y) :self.view :placeHolderButton];
            
            [mineArray addObject:aMine];
        }
        
        NSMutableDictionary* baseDictionary = [levelObjectsDictionary objectForKey:@"BaseDictionary"];
        
        CGPoint basePosition = CGPointMake([[baseDictionary objectForKey:@"BaseX"] doubleValue] ,[[baseDictionary objectForKey:@"BaseY"] doubleValue]);
        
        [levelEnemyBase initBase:levelHeadLink :5 :self.view :placeHolderButton locationOverRide:YES Position:basePosition];
        
        if (currentLevel > 12)
        {
            NSMutableDictionary* turretDictionary = [levelObjectsDictionary objectForKey:@"TurretGunDictionary"];
            CGPoint turretPosition = CGPointMake([[turretDictionary objectForKey:@"TurretX"] doubleValue], [[turretDictionary objectForKey:@"TurretY"] doubleValue]);
            [levelTurretGun initTurretGun:levelHeadLink Base:levelEnemyBase LocationOverRide:YES Position:turretPosition Velocity:CGVectorMake(0, 0) View:self.view PlaceHolder:placeHolderButton];
        }
        
        [levelGem initGem:[levelEnemyBase getPosition] :self.view :[levelEnemyBase getHealthBarImage]];
    }
    else
    {
        
        //SAVE STATIC OBJECTS TO DICTIONARY FOR POTENTIAL RESTART
        restartDictionary = [[NSMutableDictionary alloc] init];
        
        //ENEMY BASE
        [levelEnemyBase initBase:levelHeadLink :5 :self.view :placeHolderButton locationOverRide: NO Position:CGPointMake(0, 0)];

        //LEVEL GEM
        [levelGem initGem:[levelEnemyBase getPosition] :self.view :[levelEnemyBase getHealthBarImage]];

        //MINE FIELD - adding the array gained from mine field class
        if (currentLevel > 0)
        {
            [mineArray addObjectsFromArray:[MineField makeRandomMineField:levelEnemyBase headLink:levelHeadLink container:self.view placeholder:placeHolderButton]];
        }
    
        //BUILD A Mine BARRACADE
        if (currentLevel > 5 && currentLevel < 10)
        {
            [mineArray addObjectsFromArray:[MineField makeBaseBarracade:levelEnemyBase container:self.view placeHolder:placeHolderButton]];
        }
        
        //MAKE TURRET GUN
        if (currentLevel > 12)
        {
            [levelTurretGun initTurretGun:levelHeadLink Base:levelEnemyBase LocationOverRide:NO Position:CGPointMake(0, 0) Velocity:CGVectorMake(0, 0) View:self.view PlaceHolder:placeHolderButton];
            
            NSMutableDictionary* turretGunDictionary = [[NSMutableDictionary alloc] init];
            NSNumber* turretX = [NSNumber numberWithDouble:[levelTurretGun getPosition].x];
            NSNumber* turretY = [NSNumber numberWithDouble:[levelTurretGun getPosition].y];
            [turretGunDictionary setObject:turretX forKey:@"TurretX"];
            [turretGunDictionary setObject:turretY forKey:@"TurretY"];
            
            [restartDictionary setObject:turretGunDictionary forKey:@"TurretGunDictionary"];
            
        }
        
        
        //SAVE MINEFIELD TO RESTART DICTIONARY
        NSMutableDictionary* mineFieldDictionary = [[NSMutableDictionary alloc] init];
    
        for (int i = 0;i < [mineArray count]; i = i + 1)
        {
            NSNumber* x = [NSNumber numberWithDouble:[[mineArray objectAtIndex:i] getLatitude]];
            NSNumber* y = [NSNumber numberWithDouble:[[mineArray objectAtIndex:i] getLongitude]];
        
        
            [mineFieldDictionary setObject:x forKey:[NSString stringWithFormat:@"MineX%.d", i]];
            [mineFieldDictionary setObject:y forKey:[NSString stringWithFormat:@"MineY%.d", i]];
        }

        [restartDictionary setObject:mineFieldDictionary forKey:@"MineFieldDictionary"];
        
        
        //SAVE BASE TO DICAIONARY
        NSMutableDictionary* baseDictionary = [[NSMutableDictionary alloc] init];
        NSNumber* baseX = [NSNumber numberWithDouble:[levelEnemyBase getLatitude]];
        NSNumber* baseY = [NSNumber numberWithDouble:[levelEnemyBase getLongitude]];
    
        [baseDictionary setObject:baseX forKey:@"BaseX"];
        [baseDictionary setObject:baseY forKey:@"BaseY"];
        
        [restartDictionary setObject:baseDictionary forKey:@"BaseDictionary"];
        
        
        //WRITE RESTART DICTIONARY TO FILE
        [restartDictionary writeToFile:[AppFile getPathToLevelObjectsFile] atomically:YES];
    
    }
    
    
    if (currentLevel > 9)
    {
        blockadeBarricadeArray = [[NSMutableArray alloc] initWithArray:[Barracade makeBlockadeBarracade:[levelEnemyBase getPosition] View:self.view PlaceHolder:placeHolderButton]];
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
            
            [Shifting shiftMineField:mineArray];
        }
    }
    if (line == YES)
    {
        [Shifting showMineField:mineArray];
    }
    
    
    //Move bloackade barricade
    for (int i = 0; i < [blockadeBarricadeArray count]; i = i + 1)
    {
        BlockadeElement* aBlockadeElement = [blockadeBarricadeArray objectAtIndex:i];
        [aBlockadeElement moveInSquare];
    }
    
    //MAKE BLOCKADE
    if (currentLevel > 2)
    {
        blockadeCounter = blockadeCounter + 1;
        
        if (blockadeCounter > 200)
        {
            BlockadeElement* aBlockadeElement = [[BlockadeElement alloc] init];
            
            [aBlockadeElement initBlockadeElement: self.view : placeHolderButton];
        
            [blockadeArray addObject:aBlockadeElement];
            
            blockadeCounter = 0;
        }
    }
    
    //MOVING BLOCKADE
    for(int i = 0; i < [blockadeArray count]; i = i + 1)
    {
        BlockadeElement* aBlockadeElement = [blockadeArray objectAtIndex:i];
        
        [aBlockadeElement move:blockadeArray];
        
        for (int g = 0; g < [wallArray count]; g = g +1)
        {
            BasicObject* aWallLink = [wallArray objectAtIndex:g];
            
            if (fabs([aBlockadeElement getPosition].x - [aWallLink getPosition].x) < [aBlockadeElement getSize].width/2 && fabs([aBlockadeElement getPosition].y - [aWallLink getPosition].y) < [aBlockadeElement getSize].height)
            {
                [[aBlockadeElement getImage] removeFromSuperview];
                [blockadeArray removeObject:aBlockadeElement];
                
                [[aWallLink getImage] removeFromSuperview];
                [wallArray removeObject:aWallLink];
            }
        }
    }
    
    //MAKE KAMIKZES
    if (currentLevel > 15)
    {
        if (line == NO)
        {
                kamikazeCounter = kamikazeCounter + 1;
        
                if (kamikazeCounter > 250)
                {
                    kamikazeCounter = 0;
                    
                    Kamikaze* aKamikaze = [[Kamikaze alloc] init];
        
                    [aKamikaze initKamikaze:[levelHeadLink getPosition] Container:self.view PlaceHolderButton:placeHolderButton];
                    
//                    if (currentLevel > 15)
//                    {
//                        NSMutableArray* triangleSquadronArray = [Squadron makeTriangleSquadron:[levelHeadLink getPosition] container:self.view placeHolder:placeHolderButton];
//                    
//                        [kamikazeArray addObjectsFromArray:triangleSquadronArray];
//                    
//                    }
                    
                    [kamikazeArray addObject:aKamikaze];
            
            }
        }
    }
    
    //MOVE KAMIKAZE
    for (int w = 0; w < [kamikazeArray count]; w = w + 1)
    {
        Kamikaze* aKamikaze = [kamikazeArray objectAtIndex:w];
        
        if (line == YES)
        {
            if ([aKamikaze getPosition].y < screenHeight/2)
            {
                [aKamikaze kamikazeMovement:CGPointMake(-10,-10) :kamikazeArray];
            }
            if ([aKamikaze getPosition].y > screenHeight/2)
            {
                [aKamikaze kamikazeMovement:CGPointMake(screenWidth +10, screenHeight + 10) :kamikazeArray];
            }
            
        }
        else
        {
            [aKamikaze kamikazeMovement:[levelHeadLink getPosition] :kamikazeArray];
        }
        
        //KAMIKAZE WALL INTERACTION
        for (int i = 0; i < [wallArray count]; i = i + 1)
        {
            BasicObject* aWallLink = [wallArray objectAtIndex:i];
            
            if (fabs([aKamikaze getPosition].x - [aWallLink getPosition].x) < [aKamikaze getSize].width/2 && fabs([aKamikaze getPosition].y - [aWallLink getPosition].y) < [aKamikaze getSize].height)
            {
                
                [[aWallLink getImage] removeFromSuperview];
                [wallArray removeObject:aWallLink];
                [[aKamikaze getImage] removeFromSuperview];
                [kamikazeArray removeObject:aKamikaze];
                break;
                
            }
        }
    }
    
    //MAKE LIFE POWER UPS
    if ([[levelSnake getSnakeArray] count] < 40)
    {
        lifePowerUpCounter = lifePowerUpCounter + 1;
        
        if ([lifePowerUpArray count] < 4)
        {
            if (lifePowerUpCounter > 400)
            {
                lifePowerUpCounter = 0;
           
                Food* aFood = [[Food alloc] init];
            
                [aFood initFood:levelEnemyBase View:self.view placeHolder:placeHolderButton];
            
                [lifePowerUpArray addObject:aFood];
            }
        }
    }
    
    //MAKE TURRET GUN FIRE BULLETS
    if (currentLevel > 12 && line == NO)
    {
        turretGunCounter = turretGunCounter + 1;
        
        if ([levelTurretGun getTurretHealth] > 0)
        {
        
            if (turretGunCounter > 100)
            {
                turretGunCounter = 0;
            
                Arrow* anArrow = [[Arrow alloc] init];
        
                CGPoint theTarget = CGPointMake([levelHeadLink getLatitude], [levelHeadLink getLongitude]);
            
                [anArrow initArrow:theTarget InitialPosition:[levelTurretGun getPosition] Turret:levelTurretGun container:self.view placeHolder:placeHolderButton];
        
                [turretBulletArray addObject:anArrow];
            }
        }
    }
    
    
    //MOVE HEADLINK
    [levelHeadLink move:[levelSnake getSnakeArray]];
    

    //MOVE SNAKE
    [levelSnake moveSnake: levelHeadLink : mineArray :blockadeArray : kamikazeArray : levelEnemyBase : levelGem :lifePowerUpArray View:self.view Arrow:turretBulletArray TurretGut:levelTurretGun :blockadeBarricadeArray];
    
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
    
    [levelTurretGun move];

   // BULLET MOVER
    [self moveBullet];
    
    
    //GAME STATUS STUFF
    [self checkBaseHealth:regeneration];
    
    [self checkGameStatus];

}

#pragma mark - Move Bullet

-(void)moveBullet
{
    
    didBulletHit = NO;
    
    for (int a = 0; a < [turretBulletArray count]; a = a + 1)
    {
        Arrow* anArrow = [turretBulletArray objectAtIndex:a];
        [anArrow move];
        
        //BULLET REMOVAL
        if ([anArrow getPosition].x > (screenWidth + 10) || [anArrow getPosition].x < -10)
        {
            [turretBulletArray removeObjectAtIndex:a];
            [[anArrow getImage] removeFromSuperview];
        }
        if ([anArrow getPosition].y > (screenHeight + 10) || [anArrow getPosition].y < 0)
        {
            [turretBulletArray removeObjectAtIndex:a];
            [[anArrow getImage] removeFromSuperview];
        }
        
        
        //WALL INTERACTION
        for (int i = 0; i < [wallArray count]; i = i + 1)
        {
            BasicObject* object = [wallArray objectAtIndex:i];
            
            if (fabs([anArrow getPosition].x - [object getPosition].x) < [object getSize].width && fabs([anArrow getPosition].y - [object getPosition].y) < [object getSize].height)
            {
                
                [[object getImage] removeFromSuperview];
                [wallArray removeObject:object];
                
                [[anArrow getImage] removeFromSuperview];
                [turretBulletArray removeObject:anArrow];
            }
        }
    }
       
    
    for (int i = 0; i < [bulletArray count]; i = i + 1)
    {
        Bullet* aBullet = [bulletArray objectAtIndex:i];
        
        [aBullet move];
        
        [aBullet getImage].center = [aBullet getPosition];
        
        if ([aBullet getPosition].x > (screenWidth + 10) || [aBullet getPosition].x < -10)
        {
            didBulletHit = YES;
        }
        if ([aBullet getPosition].y > (screenHeight + 10) || [aBullet getPosition].y < -10)
        {
            didBulletHit = YES;
            
        }
        
        UIImageView* aBulletImage = [aBullet getImage];
            
        //BLOACKADE INTERACTION
        for (int j = 0; j < [blockadeArray count]; j = j + 1)
        {
            UIImageView* blockadeImage = [[blockadeArray objectAtIndex:j] getImage];
            
            if (fabs(aBulletImage.center.x - blockadeImage.center.x) < 15 && fabs(aBulletImage.center.y - blockadeImage.center.y) < 15)
            {
                [blockadeImage removeFromSuperview];
                [blockadeArray removeObjectAtIndex:j];
                
                didBulletHit = YES;
            }
        }
        
        //BLOCKADE BARRRICADE INTERACTION
        for (int e = 0; e < [blockadeBarricadeArray count]; e = e + 1)
        {
            BlockadeElement* aBlockadeBarricadeElement = [blockadeBarricadeArray objectAtIndex:e];
            if (fabs([aBlockadeBarricadeElement getPosition].x - [aBullet getPosition].x) < [aBlockadeBarricadeElement getSize].width/2 && fabs([aBlockadeBarricadeElement getPosition].y - [aBullet getPosition].y) < [aBlockadeBarricadeElement getSize].height/2 )
            {
                [[aBlockadeBarricadeElement getImage]removeFromSuperview];
                [blockadeBarricadeArray removeObject:aBlockadeBarricadeElement];
                
                didBulletHit = YES;
                break;
            }
        }

        //MINE FEILD INTERACTION
        for (int j = 0; j < [mineArray count]; j = j + 1)
        {
            UIImageView* mineImage = [[mineArray objectAtIndex:j] getImage];
            
            if (fabs(aBulletImage.center.x - mineImage.center.x) < 15 && fabs(aBulletImage.center.y - mineImage.center.y) < 15 )
            {
                [mineImage removeFromSuperview];
                [mineArray removeObjectAtIndex:j];
                
                didBulletHit = YES;
            }
            
        }
        
        //ENEMY BASE INTERACTION
        if ([levelEnemyBase getEnemyBaseHealth] > 0)
        {
            
            if (fabs([aBullet getLatitude] - [levelEnemyBase getLatitude]) < 12 && fabs([aBullet getLongitude] - [levelEnemyBase getLongitude]) < 12)
            {
                didBulletHit = YES;
                
                
                [levelEnemyBase hitEnemyBase];
            
            }
        }
        
        //TURRET GUN INTERACTION
        if ([levelTurretGun getTurretHealth] > 0)
        {
            if (fabs([aBullet getLatitude] - [levelTurretGun getLatitude]) < [levelTurretGun getSize].width/2 && fabs([aBullet getLongitude] - [levelTurretGun getLongitude]) < [levelTurretGun getSize].height/2)
            {
                didBulletHit = YES;
                [levelTurretGun hitTurret];
            }
        }
        
        //KAMIKAZI INTERACTION
        for (int h = 0; h < [kamikazeArray count]; h = h + 1)
        {
            UIImageView* aKamikaziImage = [[kamikazeArray objectAtIndex:h] getImage];
                
            if (fabs(aBulletImage.center.x - aKamikaziImage.center.x) < 10 && fabs(aBulletImage.center.y - aKamikaziImage.center.y) < 10)
            {
                [aKamikaziImage removeFromSuperview];
                [kamikazeArray removeObjectAtIndex:h];
                    
                didBulletHit = YES;
            }

        }
        
        
        
        
        //THis is the polling thing i need to change
        if (didBulletHit == YES)
        {
            [aBulletImage removeFromSuperview];
            [bulletArray removeObjectAtIndex:i];
        }

    }
    
    
}


#pragma mark - Game Checkers


-(void)checkBaseHealth:(BOOL)regeneration
{
    
    if ([levelEnemyBase getEnemyBaseHealth] == 0)
    {
        [[levelEnemyBase getImage] removeFromSuperview];
    }
    
    
    if ([levelEnemyBase getEnemyBaseHealth] < [levelEnemyBase getBaseHealthCap] && [levelEnemyBase getEnemyBaseHealth] > 0 && currentLevel > 10)
    {
        healthRegenerationCounter = healthRegenerationCounter + 1;
        
        if (healthRegenerationCounter > 200)
        {
            [levelEnemyBase addHealth:self.view :placeHolderButton];
            healthRegenerationCounter = 0;
        }
    }

    
    if ([levelTurretGun getTurretHealth] == 0)
    {
        [[levelTurretGun getImage] removeFromSuperview];
    }

}

-(void)checkGameStatus
{
    if (gameStatus == NO)
    {
        [self youLost:[NSString stringWithFormat:@"DIED ON LEVEL %.f",currentLevel]];
    }
    
    if (won == YES)
    {
        [self youWon];
    }
}

-(BOOL)checkShapeShiftStatus
{
    return shapeShiftBool;
}

#pragma mark - Winners and Losers

-(void)youWon
{
    [theTimer invalidate];
    
    //SAVE LEVEL STATUS AND INFO
    NSString* levelString = [NSString stringWithFormat: @"%.f",currentLevel + 1];
    
    NSMutableDictionary* dictionaryFromFile = [NSMutableDictionary dictionaryWithContentsOfFile:[AppFile getPathToUserInfoFile]];
    
    [dictionaryFromFile setObject:levelString forKey:@"currentLevel"];

    [dictionaryFromFile setObject:[NSString stringWithFormat:@"%.f",(double)[[levelSnake getSnakeArray] count]] forKey:@"snakeLength"];
    
    [dictionaryFromFile writeToFile:[AppFile getPathToUserInfoFile] atomically:YES ];
    
    won = NO;
    
    backgroundImage = [self makeGreenBackgroundMenuImage];
    
    pauseButton.hidden = YES;
    
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
    
    endLevelLabel.text = [NSString stringWithFormat:@"YOU BEAT LEVEL %.f!",currentLevel];
    currentLevel = currentLevel + 1;
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


-(void)youLost:(NSString*)reasonStringInit
{
    [theTimer invalidate];
    
    //REMOVE IMAGES FROM SCREEN
    [mineArray removeAllObjects];
    [bulletArray removeAllObjects];
    [[levelEnemyBase getImage] removeFromSuperview];
    [[levelGem getImage] removeFromSuperview];
    
    //INSERT BACKGROUND IMAGE
    backgroundImage = [self makeRedBackgroundMenuImage];
    [self.view insertSubview:backgroundImage aboveSubview:placeHolderButton];
    
    endLevelLabel.text = reasonStringInit;
    endLevelLabel.hidden = NO;
    pauseButton.hidden = YES;
    ammoCount.hidden = YES;
    levelCountLabel.hidden = YES;
    shapeUnlockLabel.hidden = YES;
    
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

#pragma mark - Background Images


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


#pragma mark - UI Gestures


-(void)establishGestures:(UIView*)container
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
    
    [container addGestureRecognizer:singleTap];
    [container addGestureRecognizer:longPress];
    [container addGestureRecognizer:doubleDoubleTap];
    [container addGestureRecognizer:swipeUp];
    [container addGestureRecognizer:swipeDown];
    [container addGestureRecognizer:swipeRight];
    [container addGestureRecognizer:swipeLeft];
    [container addGestureRecognizer:doubleLongPress];
    [container addGestureRecognizer:pinch];
    [container addGestureRecognizer:doubleSwipeDown];
}



//LONG PRESS
-(void)longPress: (UILongPressGestureRecognizer *)aLongPress
{
    if (aLongPress.state == UIGestureRecognizerStateBegan)
    {
        if (shapeShiftBool == NO)
        {
            shapeShiftBool = YES;
            circle = YES;
        }
        
        if (square == YES)
        {
           bigBulletTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(bigBulletCounter) userInfo:nil repeats:YES];
        }
        
        if (triangle == YES)
        {
            ammoCount.backgroundColor = [UIColor greenColor];
        }
        
    }
    
    if (aLongPress.state == UIGestureRecognizerStateEnded)
    {
        
        [bigBulletTimer invalidate];
        
        if (square == YES)
        {
            CGPoint touchTarget = [aLongPress locationInView:self.view];
            
            Bullet* newBullet = [[Bullet alloc] init];
            
            //MAKE A BIG BULLET
            CGSize bulletSize = CGSizeMake(bigBulletCounter, bigBulletCounter);
            
            [newBullet setSize:bulletSize];
            
            [newBullet initBullet:touchTarget InitialPosition:[levelHeadLink getShapeCenter] Container:self.view PlaceHolder:placeHolderButton];
            
            [bulletArray addObject:newBullet];
            
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
            BasicObject* aLink = [[BasicObject alloc] init];
            [aLink initBasicObject:location :CGSizeMake(10, 10) :@"Point"];
            [levelSnake removeHowManyLinksFromSnake:1];
            
            [self.view insertSubview:[aLink getImage] belowSubview:placeHolderButton];
        
            [wallArray addObject:aLink];
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


//DOUBLE TAP
-(void)didDoubleTap:(UITapGestureRecognizer*)aDoubleTap //double tap with two fingers
{
    if (shapeShiftBool == NO && currentLevel > 7)
    {
        shapeShiftBool = YES;
        square = YES;
    }
}


//SINGLE TAP
-(void)didSingleTap:(UITapGestureRecognizer*)aSingleTap
{
    if (shapeShiftBool == YES)
    {
        if ([[levelSnake getSnakeArray] count] > 0 && line == NO)
        {
            CGPoint touchTarget = [aSingleTap locationInView:self.view];
            
            if (circle == YES || line == YES || triangle == YES)
            {
            
            Bullet* newBullet = [[Bullet alloc] init];
            
            CGSize bulletSize = CGSizeMake(10, 10);
            
            [newBullet setSize:bulletSize];

            [newBullet initBullet:touchTarget InitialPosition:[levelHeadLink getShapeCenter] Container:self.view PlaceHolder: placeHolderButton];
            
        
            [bulletArray addObject:newBullet];
                
            }
            
            if (square == YES)
            {
                
                DoubleBullet* aDoubleBullet = [[DoubleBullet alloc] init];
            
                [bulletArray addObjectsFromArray: [aDoubleBullet createDoubleBullet:levelHeadLink container:self.view placeHolder:placeHolderButton Target:touchTarget]];
        
            }
            
            [levelSnake removeHowManyLinksFromSnake:1];
        }
    }
    
}


//SWIPING
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


//PINCHING
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
}


-(IBAction)didPressCirlcShapeShiftButton:(id)sender
{
    circlShapeButton.contentEdgeInsets = UIEdgeInsetsMake(35, 70, 35, 70);
    NSLog(@"I pressed the button");
}


@end