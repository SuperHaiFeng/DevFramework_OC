//
//  ZFStatusToolBar.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatusToolBar.h"
#import "ZFStatusViewModel.h"

@implementation ZFStatusToolBar

-(void)setViewModel:(ZFStatusViewModel *)viewModel {
    [_retweetedButton setTitle:viewModel.retweetedStr forState:UIControlStateNormal];
    [_commentButton setTitle:viewModel.commentsStr forState:UIControlStateNormal];
    [_likeButton setTitle:viewModel.likeStr forState:UIControlStateNormal];
}

@end
