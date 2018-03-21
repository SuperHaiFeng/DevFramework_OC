//
//  ZFStatusViewModel.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFStatuses;

@interface ZFStatusViewModel : NSObject

@property (nonatomic, strong) ZFStatuses *status;

#pragma mark - 以下是计算性属性
///会员图标
@property (nonatomic, strong) UIImage *memberIcon;
//////认证类型 -1：没有认证，0：认证用户。2，3，5：企业认证，220:达人
@property (nonatomic, strong) UIImage *vipIcon;
///转发文字
@property (nonatomic, copy) NSString *retweetedStr;
///评论文字
@property (nonatomic, copy) NSString *commentsStr;
///点赞文字
@property (nonatomic, copy) NSString *likeStr;
///配图视图大小
@property (nonatomic, assign) CGSize pictureViewSize;
///如果有被转发的微博，返回被转发微博的配图，否则返回原创微博的配图
@property (nonatomic, strong) NSMutableArray *picURLs;
///转发微博的文本
@property (nonatomic, copy) NSString *retweetedText;
///缓存行高
@property (nonatomic, assign) CGFloat rowHeight;

-(void) init: (ZFStatuses *) model;
///调用单个图片，更新配图的大小
-(void) updateSingleImage: (UIImage *) image;

@end
