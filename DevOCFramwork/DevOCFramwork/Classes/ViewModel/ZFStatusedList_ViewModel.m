//
//  ZFStatusedList_ViewModel.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatusedList_ViewModel.h"
#import <Foundation/Foundation.h>
#import "ZFStatusViewModel.h"
#import "ZFStatuses.h"
#import "ZFStatusPicture.h"
#import "ZFStatusViewModel.h"
#import <UIImageView+WebCache.h>

int maxPullupTryTimes = 3;

@interface ZFStatusedList_ViewModel()

@property(nonatomic, assign) int pullupEroorTimes;


@end

@implementation ZFStatusedList_ViewModel
/**
 如果类需要使用 ‘KVC’或者字典转魔心钢框架设置对象值，类就需要继承自NSObject
 如果类只是包装一些代码逻辑  可以不使用任何父类，更加轻量
 OC 一律都集成NSObject
 */

/**
 实名：字典转模型数据处理
 1、字典转模型
 2 、下拉/上拉刷新
 */

-(void) loadStatus: (BOOL) pullup completion: (void(^)(BOOL isSuccess, BOOL shouldRefresh)) completion{
    if (pullup && self.pullupEroorTimes > maxPullupTryTimes) {
        completion(YES, NO);
        return;
    }
    
    ///since_id下拉，取出数组中第一条的id
    ZFStatusViewModel *status = self.statusList.firstObject;
    UInt64 since_id = pullup ? 0 : status.status.id;
    ///max_id上拉刷新
    status = self.statusList.lastObject;
    UInt64 max_id = !pullup ? 0 : status.status.id;
    
    [ZFNetworkManager.shared statusList:since_id max_id:max_id completion:^(NSString *list, BOOL isSuccess) {
        if (!isSuccess) {
            completion(NO,NO);
            return ;
        }
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[ZFStatuses class] json:list]]
        ;
        NSMutableArray *viewModelArray = [NSMutableArray array];
        for (ZFStatuses *status in array) {
            NSMutableArray *arr = [NSMutableArray array];
            if (status.retweeted_status != nil) {
                for (NSDictionary *dict in status.retweeted_status.pic_urls) {
                    ZFStatusPicture *picture = [ZFStatusPicture yy_modelWithJSON:dict];
                    [arr addObject:picture];
                }
                status.retweeted_status.pic_urls = arr;
            }else{
                for (NSDictionary *dict in status.pic_urls) {
                    ZFStatusPicture *picture = [ZFStatusPicture yy_modelWithJSON:dict];
                    [arr addObject:picture];
                }
                status.pic_urls = arr;
            }
            ZFStatusViewModel *viewModel = [[ZFStatusViewModel alloc] init];
            [viewModel init:status];
            [viewModelArray addObject:viewModel];
        }
        
        if (array == nil) {
            completion(isSuccess, NO);
            return ;
        }
        if (pullup) {
            [self.statusList addObjectsFromArray:viewModelArray];
        }else{
            [self.statusList insertObjects:viewModelArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
        }
        
        ///判断上拉刷新的数据量
        if (pullup && array.count == 0) {
            self.pullupEroorTimes ++;
            completion(isSuccess, NO);
        }else{
            [self cacheSingleImage:viewModelArray completion:completion];
        }
    }];
}

///缓存本次下载微博数据数组中的单张图片
///缓存完单张图片，并且修改配图的大小之后再回调，才能保证等比例显示单张图像
-(void) cacheSingleImage: (NSArray *) list completion: (void(^)(BOOL isSuccess, BOOL shouldRefresh)) completion {
    ///调度组
    dispatch_group_t group = dispatch_group_create();
    ///记录长度
    __block NSInteger length = 0;
    
    ///遍历数组，有单张图片的进行缓存
    for (ZFStatusViewModel *vm in list) {
        if (vm.picURLs.count != 1) {
            continue;
        }
        
        ZFStatusPicture *picture = vm.picURLs[0];
        NSString *pic = picture.thumbnail_pic;
        NSURL *url = [NSURL URLWithString:pic];
        ///下载图像
        ///downloadImage 核心方法,下载完成之后自动保存在沙盒中，文件路径是url的md5
        dispatch_group_enter(group);
        [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            UIImage *imag = image;
            NSData *dat = UIImagePNGRepresentation(imag);
            length += dat.length;
            ///缓存成功
            [vm updateSingleImage:imag];
            dispatch_group_leave(group);
        }];
    }
    ///监听调度组
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completion(YES,YES);
    });
}

-(NSMutableArray *)statusList {
    if (_statusList == nil) {
        _statusList = [NSMutableArray array];
    }
    return _statusList;
}

@end
