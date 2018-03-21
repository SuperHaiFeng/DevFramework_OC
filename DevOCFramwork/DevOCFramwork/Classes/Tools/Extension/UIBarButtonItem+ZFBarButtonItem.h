//
//  UIBarButtonItem+ZFBarButtonItem.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZFBarButtonItem)

/**
 title: 标题
 fontSize: 字体大小
 image: 图片
 horizontalAlignment: 内容排列居哪
 */

-(instancetype) init:(NSString *) title fontSize:(CGFloat)fontSize image:(UIImage *) image horizontalAlignment: (UIControlContentHorizontalAlignment) horizontalAlignment target:(id)target action:(SEL)action;

@end
