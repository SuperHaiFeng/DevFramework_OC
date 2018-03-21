//
//  ZFRefreshControl.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/3/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

///Normal:普通状态 Pulling:超过临界点，开始刷新 WillRefresh:超过临界点，并且放手
enum ZFRefreshStatu {
    Normal,
    Pulling,
    WillRefresh
};

@interface ZFRefreshControl : UIControl

-(void) beginRefreshing;
-(void) endRefreshing;
    
@end
