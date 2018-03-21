//
//  ZFStatusToolBar.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFStatusViewModel;

@interface ZFStatusToolBar : UIView

///转发
@property (weak, nonatomic) IBOutlet UIButton *retweetedButton;
///评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
///点赞
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (nonatomic, strong) ZFStatusViewModel *viewModel;

@end

