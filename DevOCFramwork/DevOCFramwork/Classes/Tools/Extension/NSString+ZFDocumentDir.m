//
//  NSString+ZFDocumentDir.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/27.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "NSString+ZFDocumentDir.h"

@implementation NSString (ZFDocumentDir)

-(NSString *) zf_appendDocumentDir{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *path = [docDir stringByAppendingPathComponent:self];
    return path;
}

@end
