//
//  ZFStatusCell.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatusCell.h"
#import "ZFStatusViewModel.h"
#import "ZFStatuses.h"
#import "ZFUser.h"
#import "UIImageView+WebImage.h"
#import "ZFStatusToolBar.h"
#import "ZFStatusPictureView.h"

@implementation ZFStatusCell

///设置视图模型
-(void)setViewModel:(ZFStatusViewModel *)viewModel {
    _statusLabel.text = viewModel.status.text;
    _nameLabel.text = viewModel.status.user.screen_name;
    _memberImageView.image = viewModel.memberIcon;
    _approveImageView.image = viewModel.vipIcon;
    ///用户头像
    [_avatarImageView zf_setImage:viewModel.status.user.profile_image_url placeHolderImage:[UIImage imageNamed:@"tabbar_me"] isAvatar:YES];
    
    ///底部工具栏
    _statusToolBar.viewModel = viewModel;
    _pictureView.viewModel = viewModel;
    
    if (self.retweedtedLabel != nil) {
        self.retweedtedLabel.text = viewModel.retweetedText;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    /**
        搞基优化（好点厉害）如果性能已经很好，不需要离屏渲染
        离屏渲染（在CPU、GPU之间来回切换）
     */
//    self.layer.drawsAsynchronously = YES;
//
//    /**
//        栅格化，异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
//        cell优化，尽量减少图层的适量，相当于就只有一层
//        停止滚动后，可以接受监听
//     */
//    self.layer.shouldRasterize = YES;
//
//    ///使用栅格化必须注意指定分辨率
//    [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    NSArray *subviews = self.contentView.subviews;
    NSMutableArray *colors = [NSMutableArray array];
    for (UIView *view in subviews) {
        if (view.backgroundColor == nil) {
            [colors addObject:[UIColor clearColor]];
        }else {
            [colors addObject:view.backgroundColor];
        }
        
    }
    
    [super setSelected:selected animated:animated];
    for (int i = 0 ; i < subviews.count; i++) {
        UIView *view = subviews[i];
        view.backgroundColor = colors[i];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    NSArray *subviews = self.contentView.subviews;
    NSMutableArray *colors = [NSMutableArray  array];
    for (UIView *view in subviews) {
        if (view.backgroundColor == nil) {
            [colors addObject:[UIColor clearColor]];
        }else{
            [colors addObject:view.backgroundColor];
        }
    }
    
    [super setHighlighted:highlighted animated:animated];
    for (int i = 0; i < subviews.count; i++) {
        UIView *view = subviews[i];
        view.backgroundColor = colors[i];
    }
}

@end
