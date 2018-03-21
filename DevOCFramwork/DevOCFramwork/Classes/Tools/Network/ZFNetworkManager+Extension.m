//
//  ZFNetworkManager+Extension.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNetworkManager+Extension.h"

@implementation ZFNetworkManager (Extension)

/**
 since_id int64若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id int64 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
-(void) statusList: (UInt64) since_id max_id: (UInt64) max_id completion: (void(^)(NSString* list, BOOL isSuccess)) completion{
    NSString *urlString = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    UInt64 max = max_id > 0 ? max_id - 1 : 0;
    
    NSDictionary *paramters = @{@"since_id":[NSString stringWithFormat:@"%llu",since_id],@"max_id":[NSString stringWithFormat:@"%llu",max]};
    
    [self tokenRequest:GET URLString:urlString parameters:paramters completion:^(id json, BOOL isSuccess) {
        ///从json获取字典数组
        NSString *result = json[@"statuses"];
        completion(result, isSuccess);
        
    }];
}
#pragma mark - OAUth相关
-(void) loadAccessToken: (NSString *) code completion: (void(^)(BOOL isSuccess)) completion{
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *parameters = @{@"client_id":AppKey,
                                 @"client_secret":AppSecret,
                                 @"grant_type":@"authorization_code",
                                 @"code":code,
                                 @"redirect_uri":RedirectURI
                                 };
    
    ///请求accesstoken
    [self request:POST URLString:urlString parameters:parameters completion:^(id json, BOOL isSuccess) {
        [self.userAccount yy_modelSetWithJSON:json];
        ///加载当前用户信息
        [self loadUserInfo:^(NSString *dict) {
            [self.userAccount yy_modelSetWithJSON:dict];
            [self.userAccount saveAccount];
            completion(isSuccess);
        }];
    }];
}
#pragma mark - 用户相关
-(void) loadUserInfo: (void(^)(NSString *dict)) completion{
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *dict = @{@"uid":self.userAccount.uid};
    [self tokenRequest:GET URLString:urlString parameters:dict completion:^(id json, BOOL isSuccess) {
        completion(json);
    }];
}

@end
