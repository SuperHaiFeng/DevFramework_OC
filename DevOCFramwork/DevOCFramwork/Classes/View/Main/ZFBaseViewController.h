//
//  ZFBaseViewController.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZFRefreshControl *refreshController;
@property(nonatomic, assign) BOOL isPullup;

-(void) setupTableView;
-(void) loadData;

@end
