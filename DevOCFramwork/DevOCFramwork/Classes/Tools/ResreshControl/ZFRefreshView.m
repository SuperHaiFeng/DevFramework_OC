//
//  ZFRefreshView.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/3/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFRefreshView.h"
#import "ZFRefreshControl.h"

@implementation ZFRefreshView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.refreshStatu = Normal;
}

+(ZFRefreshView *) refreshView{
    UINib *nib = [UINib nibWithNibName:@"ZFRefreshView" bundle:nil];
    return (ZFRefreshView *)[nib instantiateWithOwner:nib options:@{}][0];
}

-(void)setRefreshStatu:(NSInteger)refreshStatu {
    _refreshStatu = refreshStatu;
    switch (refreshStatu) {
        case Normal:{
            [_tipIcon setHidden:NO];
            [_indicator setHidden:YES];
            [_indicator stopAnimating];
            _tipLabel.text = @"继续使劲拉...";
            [UIView animateWithDuration:0.25 animations:^{
                _tipIcon.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case Pulling:{
            _tipLabel.text = @"放手就刷新...";
            [UIView animateWithDuration:0.25 animations:^{
                _tipIcon.transform = CGAffineTransformMakeRotation(M_PI - 0.01);
            }];
        }
            break;
        case WillRefresh:{
            _tipLabel.text = @"正在刷新中...";
            [_tipIcon setHidden:YES];
            [_indicator setHidden:NO];
            [_indicator startAnimating];
        }
            break;
    }
}

@end
