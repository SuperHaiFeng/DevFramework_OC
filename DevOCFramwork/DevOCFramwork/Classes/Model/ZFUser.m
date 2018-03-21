//
//  ZFUser.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFUser.h"

@implementation ZFUser

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.userId = [value integerValue];
    }
}

-(NSString *)description {
    return [self yy_modelDescription];
}


@end
