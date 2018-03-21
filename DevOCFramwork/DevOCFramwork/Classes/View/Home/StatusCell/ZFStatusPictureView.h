//
//  ZFStatusPictureView.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFStatusViewModel;

@interface ZFStatusPictureView : UIView

@property (nonatomic, strong) ZFStatusViewModel *viewModel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;

@end
