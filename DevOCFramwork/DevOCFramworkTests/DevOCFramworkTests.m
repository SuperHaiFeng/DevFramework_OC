//
//  DevOCFramworkTests.m
//  DevOCFramworkTests
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZFNetworkManager.h"
#import "ZFNetworkManager+Extension.h"

#define assertTrue(expr)            XCTAssertTrue((expr),@"")
#define assertFalse(expr)           XCTAssertFalse((expr), @"")
#define assertNil(a1)               XCTAssertNil((a1), @"")
#define assertNotNil(a1)            XCTAssertNotNil((a1), @"")
#define assertEqual(a1,a2)          XCTAssertEqual((a1), (a2), @"")
#define assertEqualObjects(a1,a2)   XCTAssertEqualObjects((a1), (a2), @"")
#define assertNotEqual(a1,a2)       XCTAssertNotEqual((a1), (a2),@"")
#define assertNotEqualObjects(a1,a2)XCTAssertNotEqualObjects((a1), (a2),@"")
#define assertAccuracy(a1,a2,acc)   XCTAssertEqualWithAccuracy((a1), (a2), (acc))

#define WAIT                                                            \
do {                                                                    \
[self expectationForNotification:@"LCUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil];                   \
} while(0);

#define NOTIFY                                                      \
do {                                                                 \
[[NSNotificationCenter defaultCenter] postNotificationName:@"LCUnitTest" object:nil]; \
} while(0);

@interface DevOCFramworkTests : XCTestCase

@end

@implementation DevOCFramworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
///单元测试
-(void) testHomeWeiboReqeust {
    
    [ZFNetworkManager.shared statusList:0 max_id:0 completion:^(NSString *list, BOOL isSuccess) {
        assertNotNil(list);
    
        NOTIFY
    }];
    WAIT
}

@end
