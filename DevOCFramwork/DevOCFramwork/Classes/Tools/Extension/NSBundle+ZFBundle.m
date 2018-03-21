//
//  NSBundle+ZFBundle.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "NSBundle+ZFBundle.h"

@implementation NSBundle (ZFBundle)

+(NSString *)bundleName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *bundleName = [infoDictionary objectForKey:(NSString *)kCFBundleNameKey];
    return bundleName;
}

@end
