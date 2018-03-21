//
//  UIBarButtonItem+ZFBarButtonItem.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "UIBarButtonItem+ZFBarButtonItem.h"

@implementation UIBarButtonItem (ZFBarButtonItem)

-(instancetype) init:(NSString *) title fontSize:(CGFloat)fontSize image:(UIImage *) image horizontalAlignment: (UIControlContentHorizontalAlignment) horizontalAlignment target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    if (image != nil) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(12, -5, 12, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    }
    btn.contentHorizontalAlignment = horizontalAlignment;
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.frame = CGRectMake(0, 0, 85, 44);
    
    return [self initWithCustomView:(UIView *) btn];
}

@end
