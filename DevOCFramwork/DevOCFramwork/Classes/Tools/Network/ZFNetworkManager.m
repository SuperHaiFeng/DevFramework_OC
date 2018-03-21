//
//  ZFNetworkManager.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/8.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNetworkManager.h"

@implementation ZFNetworkManager

+(instancetype)shared {
    static dispatch_once_t onceToken;
    static ZFNetworkManager *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(BOOL) userLogin{
    return self.userAccount.access_token != nil;
}

#pragma mark - 专门负责拼接token的网络请求方法
-(void) tokenRequest : (NSInteger) method URLString: (NSString *) URLString parameters: (NSDictionary *) parameters completion:(void (^)(id json, BOOL isSuccess)) completion{
    if (self.userAccount.access_token == nil) {
        completion(nil, NO);
        return;
    }
    
    ///判断参数字典是否存在，如果为nil，应该新建一个字典
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    if (parameter == nil) {
        parameter = [NSMutableDictionary new];
    }
    
    [parameter setValue:self.userAccount.access_token forKey:@"access_token"];
    ///调用request发起真正的请求方法
    [self request:method URLString:URLString parameters:parameter completion:completion];
}

#pragma mark - 封装AFN的get和post方法
-(void) request: (NSInteger) method URLString: (NSString *) URLString parameters: (NSDictionary *) parameters completion:(void (^)(id json, BOOL isSuccess)) completion{
    if (method == GET) {
        [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completion(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ///针对403错误码（token过期）
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            if (response.statusCode == 403) {
                NSLog(@"token过期%ld",response.statusCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:ZFUserShouldLoginNotification object:@"bad token"];
            }
        }];
    }else{
        [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completion(responseObject, YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            if (response.statusCode == 403) {
                NSLog(@"token过期%ld",response.statusCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:ZFUserShouldLoginNotification object:@"bad token"];
            }
        }];
    }
}

-(ZFUserAccount *)userAccount {
    if (_userAccount == nil) {
        _userAccount = [[ZFUserAccount alloc] init];
    }
    return _userAccount;
}

@end
