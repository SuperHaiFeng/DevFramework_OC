//
//  ZFWelcomView.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFWelcomView.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+WebImage.h"

@implementation ZFWelcomView

-(void)awakeFromNib {
    [super awakeFromNib];
    NSString *urlString = ZFNetworkManager.shared.userAccount.avatar_large;

    ///设置头像
    [self.iconImage zf_setImage:urlString placeHolderImage:[UIImage imageNamed:@"tabbar_me_selected"] isAvatar:YES];
    self.iconImage.layer.cornerRadius = self.iconWidth.constant / 2;
    self.iconImage.layer.masksToBounds = YES;
    self.tipLabel.text = ZFNetworkManager.shared.userAccount.screen_name;
}

///视图被添加到window上，表示视图已经显示
-(void)didMoveToWindow {
    [super didMoveToWindow];
    ///视图是使用自动布局设置的,只是设置了约束，当天家到视图上时，根据父视图的大小，计算约束值，更新控件位置
    [self layoutIfNeeded];
    self.bottomCons.constant = self.bounds.size.height - 200;
    ///如果控件们的frame还没计算好，所有的约束一起动画
    [UIView animateWithDuration:1.0
                          delay:0.5
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         ///更新约束
                         [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.tipLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }];
}

@end
