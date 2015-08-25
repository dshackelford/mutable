//
//  MutableTests.m
//  MutableTests
//
//  Created by Dylan Shackelford on 3/18/15.
//  Copyright (c) 2015 Dylan Shackelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>



@interface MutableTests : XCTestCase

@end

@implementation MutableTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // This is an example of a functional test case.

    
    NSString* value = @"key 1";
    NSString* separator = @":";
//    NSString* className = [self getSubstring:key betweenString:@" "];
    
    NSString* firstWord = [[value componentsSeparatedByString:@" "] objectAtIndex:0];
    
    
//    NSRange firstInstance = [value rangeOfString:separator];
//    NSRange secondInstance = [[value substringFromIndex:firstInstance.location + firstInstance.length] rangeOfString:separator];
//    NSRange finalRange = NSMakeRange(firstInstance.location + separator.length, secondInstance.location);
//    
//    return [value substringWithRange:finalRange];
    
    int x = 1;
    
    XCTAssert(x == 2, @"PASS");

}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        
        // Put the code you want to measure the time of here.
        
    }];
}

@end
