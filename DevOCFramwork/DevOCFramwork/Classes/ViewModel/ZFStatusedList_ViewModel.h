//
//  ZFStatusedList_ViewModel.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZFStatusViewModel;

@interface ZFStatusedList_ViewModel : NSObject

@property(nonatomic, strong) NSMutableArray<ZFStatusViewModel *> *statusList;

-(void) loadStatus: (BOOL) pullup completion: (void(^)(BOOL isSuccess, BOOL shouldRefresh)) completion;

@end
