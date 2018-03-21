//
//  ZFStatuses.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatuses.h"
#import "ZFStatusPicture.h"

@implementation ZFStatuses

-(NSString *)description {
    return [self yy_modelDescription];
}

///yymodel的类函数(遇到数组类型的属性，数组中存放的对象什么类
-(NSDictionary *) modelContainerPropertyGenericClass {
    return @{@"pic_urls" : [ZFStatusPicture class]};
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
