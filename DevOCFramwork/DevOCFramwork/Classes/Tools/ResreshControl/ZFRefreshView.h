//
//  ZFRefreshView.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/3/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFRefreshView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *tipIcon;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

///刷新状态
@property (nonatomic, assign) NSInteger refreshStatu;

+(ZFRefreshView *) refreshView;

@end
