//
//  AppFile.m
//  Mutable
//
//  Created by Dylan Shackelford on 7/4/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppFile.h"

@implementation AppFile

+(NSString*) getPathToUserInfoFile
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

+(BOOL) doesFileExistAtPath:(NSString *)path
{
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return exists;
}

@end