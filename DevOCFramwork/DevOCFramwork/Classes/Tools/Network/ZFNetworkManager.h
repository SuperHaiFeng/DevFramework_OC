//
//  ZFNetworkManager.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/8.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "ZFUserAccount.h"

enum ZFHTTPMethod {
    GET,
    POST
};

@interface ZFNetworkManager : AFHTTPSessionManager

@property (nonatomic, strong) ZFUserAccount *userAccount;

+(instancetype) shared;
-(BOOL) userLogin;

-(void) tokenRequest : (NSInteger) method URLString: (NSString *) URLString parameters: (NSDictionary *) parameters completion:(void (^)(id json, BOOL isSuccess)) completion;

#pragma mark - 封装AFN的get和post方法
-(void) request: (NSInteger) method URLString: (NSString *) URLString parameters: (NSDictionary *) parameters completion:(void (^)(id json, BOOL isSuccess)) completion;

@end
