//
//  ZFUserAccount.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/27.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFUserAccount : NSObject

///访问令牌
@property(nonatomic, copy) NSString *access_token;
@property(nonatomic, copy) NSString *uid;
///过期日期
@property(nonatomic, strong) NSDate *expiresDate;
///用户昵称
@property(nonatomic, copy) NSString *screen_name;
///用户头像
@property(nonatomic, copy) NSString *avatar_large;
@property(nonatomic, assign) NSTimeInterval expires_in;

/**
 保存用户信息
 1、偏好设置
 2、沙盒-归档/plist/json
 3、数据库(FMDB/CoreData)
 4、钥匙串(使用框架 SSKeychain)
 */
-(void) saveAccount;


@end
