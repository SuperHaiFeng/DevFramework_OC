//
//  ZFStatuses.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFStatusPicture;
@class ZFUser;

@interface ZFStatuses : NSObject

@property(nonatomic, assign) UInt64 id;
///微博信息内容
@property(nonatomic, copy) NSString *text;
///转发数
@property(nonatomic, assign) NSInteger reposts_count;
///评论数
@property(nonatomic, assign) NSInteger comments_count;
///点赞数
@property(nonatomic, assign) NSInteger attitudes_count;
///配图模型数组
@property(nonatomic, strong) NSMutableArray<ZFStatusPicture *> *pic_urls;
///被转发的原创微博
@property(nonatomic, strong) ZFStatuses *retweeted_status;

///用户
@property(nonatomic, strong) ZFUser *user;

@end
