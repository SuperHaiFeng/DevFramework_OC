//
//  ZFNibLoadable.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNibLoadable.h"

@implementation ZFNibLoadable

+(UIView *)loadFromNib:(NSString *)nibName {
    UIView *v = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
    v.frame = [UIScreen mainScreen].bounds;
    return v;
}

@end
