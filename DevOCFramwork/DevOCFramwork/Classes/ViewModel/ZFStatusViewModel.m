//
//  ZFStatusViewModel.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatusViewModel.h"
#import "ZFStatuses.h"
#import "ZFUser.h"
#import "ZFStatusPicture.h"

@implementation ZFStatusViewModel

///构造函数
-(void) init: (ZFStatuses *) model{
    self.status = model;
    ///直接计算会员图标/会员等级0-6
    if (model.user.mbrank > 0 && model.user.mbrank <= 7) {
        NSString *imageName = [NSString stringWithFormat:@"vip%ld",(long)model.user.mbrank];
        self.memberIcon = [UIImage imageNamed:imageName];
    }
    
    ///计算vip
    switch (model.user.verified_type) {
        case 0:
            _vipIcon = [UIImage imageNamed:@"normal"];
            break;
        case 2:case 3:case 5:
            _vipIcon = [UIImage imageNamed:@"compony"];
            break;
        case 220:
            _vipIcon = [UIImage imageNamed:@"glass"];
            break;
    }
    
    ///设置底部计数字符串
    _retweetedStr = [self countString:model.reposts_count defaultStr:@"转发"];
    _commentsStr = [self countString:model.comments_count defaultStr:@"评论"];
    _likeStr = [self countString:model.attitudes_count defaultStr:@"赞"];
    
    _pictureViewSize = [self calcPictureViewSize:self.picURLs.count];
    
    ///设置被转发微博的文字
    _retweetedText = [NSString stringWithFormat:@"@%@:%@",_status.retweeted_status.user.screen_name,_status.retweeted_status.text];
    
    ///更新行高
    [self updateRowHeight];
}

///计算配图视图大小
-(CGSize) calcPictureViewSize: (NSInteger) count {
    if (count == 0) {
        return CGSizeZero;
    }
    
    ///计算高度
    CGFloat row = (count - 1) / 3 + 1;
    
    CGFloat height = ZFStatusPictureViewOutterMargin;
    height += row * ZFStatusPictureItemWidth;
    height += (row - 1) * ZFStatusPictureViewInnerMargin;
    
    return CGSizeMake(ZFStatusPictureViewWidth, height);
}

-(NSMutableArray *)picURLs {
    if (_picURLs == nil) {
        _picURLs = [NSMutableArray array];
    }
    return self.status.retweeted_status != nil ? self.status.retweeted_status.pic_urls : self.status.pic_urls;
}

///给定一个数字，返回对应的描述结果
-(NSString *) countString : (NSInteger) count defaultStr : (NSString *) defaultStr{
    if (count == 0) {
        return defaultStr;
    }
    if (count < 10000) {
        return [NSString stringWithFormat:@"%ld",count];
    }
    
    return [NSString stringWithFormat:@"%.1f万",count / 10000.0];
}

///调用单个图片，更新配图的大小
-(void) updateSingleImage: (UIImage *) image {
    CGSize size = image.size;
    ///过宽图像处理
    CGFloat maxWidth = 300;
    CGFloat minWidth = 40;
    if (size.width > 40) {
        ///设置最大宽度
        size.width = maxWidth;
        ///等比例调整高度
        size.height = size.width * image.size.height / image.size.width;
    }
    
    ///过窄的图像处理
    if (size.width < maxWidth) {
        size.width = minWidth;
        ///要特殊处理高度，高度过大影响用户体验
        size.height = size.width * image.size.height / image.size.width;
    }
    ///特例：有些图像，本身就很窄很长
    
    size.height += ZFStatusPictureViewOutterMargin;
    ///重新设置配置视图大小
    _pictureViewSize = size;
    ///更新行高
    [self updateRowHeight];
}

///根据当前的视图模型计算行高
-(void) updateRowHeight {
    CGFloat top = 8;
    CGFloat margin = 12;
    CGFloat iconHeight = 34;
    CGFloat toolbarHeight = 35;
    
    CGFloat height = 0;
    
    CGSize viewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * margin, MAXFLOAT);
    UIFont *originalFont = [UIFont systemFontOfSize:15];
    UIFont *retweedtedFont = [UIFont systemFontOfSize:14];
    
    height = top + margin + iconHeight +margin;
    
    ///计算正文高度
    NSString *text = self.status.text;
    if (text != nil) {
        height += [text boundingRectWithSize:viewSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:originalFont}
                                     context:nil].size.height;
        
    }
    
    ///判断是否是转发微博
    if (self.status.retweeted_status != nil) {
        height += 2 * margin;
        NSString *text = self.retweetedText;
        if (text != nil) {
            height += [text boundingRectWithSize:viewSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:retweedtedFont}
                                         context:nil].size.height;
        }
    }
    
    ///配图视图
    height += self.pictureViewSize.height;
    height += margin;
    height += toolbarHeight;
    self.rowHeight = height;
}

@end
