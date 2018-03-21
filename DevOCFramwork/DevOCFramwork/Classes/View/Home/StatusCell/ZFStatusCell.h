//
//  ZFStatusCell.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFStatusViewModel;
@class ZFStatusToolBar;
@class ZFStatusPictureView;

@interface ZFStatusCell : UITableViewCell
///昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
///会员
@property (weak, nonatomic) IBOutlet UIImageView *memberImageView;
///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
///来源
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
///正文
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
///认证
@property (weak, nonatomic) IBOutlet UIImageView *approveImageView;
///底部工具栏
@property (weak, nonatomic) IBOutlet ZFStatusToolBar *statusToolBar;

@property (weak, nonatomic) IBOutlet ZFStatusPictureView *pictureView;
///被转发微博的text（设置可选的）
@property (weak, nonatomic) IBOutlet UILabel *retweedtedLabel;

@property (nonatomic, strong) ZFStatusViewModel *viewModel;

@end
