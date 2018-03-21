//
//  ZFUserAccount.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/27.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFUserAccount.h"
#import "NSString+ZFDocumentDir.h"
#import <YYModel.h>

const NSString *accountFile = @"useraccount.json";

@interface ZFUserAccount()

@end

@implementation ZFUserAccount


- (instancetype)init
{
    self = [super init];
    if (self) {
        ///从磁盘加载保存的文件
        NSString *path = [accountFile zf_appendDocumentDir];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        if (data == nil) {
            return self;
        }
        NSString *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        ///使用字典设置属性值
        [self yy_modelSetWithJSON:dict];
        
        ///判断token是否过期
        if ([self.expiresDate compare:[NSDate new]] == NSOrderedAscending) {
            self.access_token = nil;
            self.uid = nil;
            [NSFileManager.defaultManager removeItemAtPath:path error:nil];
        }
    }
    return self;
}

-(void)setExpires_in:(NSTimeInterval)expires_in{
    self.expiresDate = [NSDate dateWithTimeIntervalSinceNow:expires_in];
    
}

-(void) saveAccount{
    ///模型转字典
    NSMutableDictionary *dict = [self yy_modelToJSONObject];
    [dict removeObjectForKey:@"expires_in"];
    ///序列化
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *filePath = [accountFile zf_appendDocumentDir];
    
    if (data != nil) {
        [data writeToFile:filePath atomically:YES];
    }
}

-(NSString *)description{
    return [self yy_modelDescription];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
