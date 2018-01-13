//
//  AppFile.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/4/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUtilities.h"
#import "AppConstants.h"
#import "BasicObject.h"
#import "Base.h"

@implementation AppUtilities

#pragma mark - File Utitlies
+(NSString*)getPathToUserInfoFile
{
    NSString* homeDirectoryString = NSHomeDirectory();
    NSString* pathToUserInfoFile = [homeDirectoryString stringByAppendingPathComponent:@"/Documents/userInfo"];
    return pathToUserInfoFile;
}


+(NSString*)getPathToLevelObjectsFile
{
    NSString* homeDirectoryString = NSHomeDirectory();
    NSString* pathToLevelObjectsFile = [homeDirectoryString stringByAppendingPathComponent:@"/Documents/levelObjects"];
    return pathToLevelObjectsFile;
}

+(BOOL)doesFileExistAtPath:(NSString *)path
{
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return exists;
}


#pragma mark - Restart Utilities
+(void)saveLevelForRestart
{
    NSMutableDictionary* aDictionary = [[NSMutableDictionary alloc] init];
    
    //ITERATE THROUGH EACH OBJECT
    for (int i = 0; i < [objectArray count]; i = i + 1)
    {
        id object = [objectArray objectAtIndex:i];
        
        //MAKE A LOCAL DICTIONARY
        NSMutableDictionary* anotherDictionary = [[NSMutableDictionary alloc] init];
        
        //ADD EACH OBJECT'S X AND Y LOCATIONS
        [anotherDictionary setObject:[NSNumber numberWithDouble:[object getPosition].x ] forKey:@"x"];
        [anotherDictionary setObject:[NSNumber numberWithDouble:[object getPosition].y] forKey:@"y"];
        
        [anotherDictionary setObject:[NSNumber numberWithDouble:[object getVelocity].dx] forKey:@"dx"];
        
        [anotherDictionary setObject:[NSNumber numberWithDouble:[object getVelocity].dy] forKey:@"dy"];
        
        //SAVE LOCAL DICTIONARY TO BIGGER DICTIONARY WITH KEY OF OBJECT ELEMENT NUMBER
        //CHECK IF KEY ALREADY EXITS, MAINLY FOR THE MINEFIELD
        if ([aDictionary objectForKey:[NSString stringWithFormat:@"%@",[object class]]] == nil)
        {
            [aDictionary setObject:anotherDictionary forKey:[NSString stringWithFormat:@"%@",[object class]]];
        }
        else
        {
            NSString* aString = [NSString stringWithFormat:@"%@ %i",[object class],i];
            
            [aDictionary setObject:anotherDictionary forKey:aString];
        }
    }
    
    //WRITE DICTIONARY TO FILE FOR SAVE
    [aDictionary writeToFile:[AppUtilities getPathToLevelObjectsFile] atomically:YES];
    
}


+(void)getObjectsForLevelRestart:(UIView*)container :(UIButton*)placeHolderButton
{
    //GRAB DICTIONARY FROM FILE FOR RESTART
    NSMutableDictionary* aDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[AppUtilities getPathToLevelObjectsFile]];
    
    NSDictionary* baseDictionary = [aDictionary objectForKey:@"Base"];
    
    CGPoint basePostion = CGPointMake([[baseDictionary objectForKey:@"x"] doubleValue],[[baseDictionary objectForKey:@"y"] doubleValue]);
    
    Base* aBase  = [[Base alloc] initRestart:basePostion Container:container Placeholder:placeHolderButton Velocity:CGVectorMake(0, 0)];
    
    //ITERATE THROUGH DICTIONARY TO GRAB EACH SMALLER DICATIONARY FOR EACH OBJECT
    for (NSString* key in [aDictionary allKeys])
    {
        //GRAB SMALLER DICTIONARY THAT HOLDS THE X AND Y and dx & dy
        NSDictionary* smallDictionary = [aDictionary objectForKey:key];
        
        NSString* className = [[key componentsSeparatedByString:@" "] objectAtIndex:0];
        
        if ([className isEqualToString:@"Base"])
        {
            
        }
        else
        {
            CGPoint postion = CGPointMake([[smallDictionary objectForKey:@"x"] doubleValue],[[smallDictionary objectForKey:@"y"] doubleValue]);
            
            CGVector velocity = CGVectorMake([[smallDictionary objectForKey:@"dx"] doubleValue], [[smallDictionary objectForKey:@"dy"] doubleValue]);
            
            id object = [[NSClassFromString(className) alloc] initRestart:postion Container:container Placeholder:placeHolderButton Velocity:velocity];
        }
    }    
}

@end