//
//  ZFUser.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFUser : NSObject

@property(nonatomic, assign) UInt64 userId;
///用户昵称
@property(nonatomic, copy) NSString *screen_name;
///用户头像地址
@property(nonatomic, copy) NSString *profile_image_url;
///认证类型-1：没有认证，0：认证用户。2，3，5：企业认证，220:达人
@property(nonatomic, assign) NSInteger verified_type;
///会员等级
@property(nonatomic, assign) NSInteger mbrank;

@end
