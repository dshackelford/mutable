//
//  AppFile.h
//  Mutable
//
//  Created by Dylan Shackelford on 7/4/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AppFile : NSObject
{
 
}

+(NSString*) getPathToUserInfoFile;
+(NSString*)getPathToLevelObjectsFile;

+(BOOL) doesFileExistAtPath: (NSString*)path;

@end
