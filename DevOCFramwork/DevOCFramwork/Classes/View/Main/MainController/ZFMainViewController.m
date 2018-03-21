//
//  ZFMainViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFMainViewController.h"
#import "NSBundle+ZFBundle.h"
#import "ZFNavigationViewController.h"
#import "ZFHomeViewController.h"
#import "ZFOAuthViewController.h"
#import "NSString+ZFDocumentDir.h"
#import "ZFNewFeatureView.h"
#import "ZFWelcomView.h"
#import <SVProgressHUD.h>

@interface ZFMainViewController ()

@property (nonatomic, strong) UIButton *composeButton;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildController];
    [self setupComposeButton];
    [self setupNewFeatureView];
    [self setupTimer];
    ///设置代理
    self.delegate = self;
    
    ///注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:ZFUserShouldLoginNotification object:nil];
}

-(void) setupNewFeatureView {
    UIView *v = [self isNewVersion] ? [ZFNewFeatureView loadFromNib:@"ZFNewFeatureView"] : [ZFWelcomView loadFromNib:@"ZFWelcomView"];
    [self.view addSubview:v];
    
}

-(BOOL) isNewVersion {
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *path = [@"version" zf_appendDocumentDir];
    NSString *sandboxVersion = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [currentVersion writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return ![currentVersion isEqualToString:sandboxVersion];
}

-(void) userLogin: (NSNotification *) notifucation {
    if (notifucation.object != nil) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD showInfoWithStatus:@"用户登录超时，请重新登录"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ZFOAuthViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    });
    
}

#pragma mark - 设置计时器，请求未读数
-(void) setupTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

-(void) updateTimer {
    ///请求未读数量
    if (![ZFNetworkManager.shared userLogin]) {
        return;
    }
    self.tabBar.items[0].badgeValue = @"8";
    UIApplication.sharedApplication.applicationIconBadgeNumber = 8;
}

-(void)dealloc {
    [self.timer invalidate];
}

-(void) setupComposeButton{
    self.composeButton = [[UIButton alloc] init];
    [self.composeButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.composeButton setBackgroundImage:[UIImage imageNamed:@"R"] forState:UIControlStateNormal];
    [self.tabBar addSubview:self.composeButton];
    
    ///计算按钮的高度
    NSInteger count = self.childViewControllers.count;
    CGFloat w = self.tabBar.bounds.size.width/count;
    self.composeButton.frame = CGRectMake(w * 2, 0, w, self.tabBar.bounds.size.height);
    [self.composeButton addTarget:self action:@selector(composeStatus) forControlEvents:UIControlEventTouchUpInside];
}

-(void) composeStatus {
    NSLog(@"撰写微博");
}

-(void) setupChildController{
    /**
    NSArray *array = @[
                       @{@"clsName":@"ZFHomeViewController",@"title":@"首页",@"imageName":@"firstPage"},
                       @{@"clsName":@"ZFMessageViewController",@"title":@"信息",@"imageName":@"subject"},
                       @{@"clsName":@""},
                       @{@"clsName":@"ZFDiscoveryViewController",@"title":@"发现",@"imageName":@"teacher"},
                       @{@"clsName":@"ZFProfileViewController",@"title":@"我",@"imageName":@"me"},
                       ];
    
    ///数组->json 写入文件
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    [data writeToFile:@"/Users/Andy/Desktop/demo.json" atomically:YES];
    */
    
    ///获取沙盒json路径
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *jsonPath = [docDir stringByAppendingPathComponent:@"main.json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
    if (data == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"main.json" ofType:nil];
        data = [[NSData alloc] initWithContentsOfFile:path];
    }
    
    ///反序列化
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self controller:dict]];
    }
    self.viewControllers = arrayM;
}

-(UIViewController *) controller:(NSDictionary *)dict{
    NSString *clsName = dict[@"clsName"];
    NSString *title = dict[@"title"];
    NSString *imageName = dict[@"imageName"];
    
    
    UIViewController *clsControler = (UIViewController *)[[NSClassFromString(clsName) alloc] init];
    if (clsControler == nil) {
        return [UIViewController new];
    }
    
    [clsControler setTitle:title];
    [clsControler.tabBarItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%@",imageName]]];
    UIImage *selectImg = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%@_selected",imageName]];
    selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [clsControler.tabBarItem setSelectedImage:selectImg];
    [self.tabBar setTintColor:[UIColor grayColor]];
    
    ZFNavigationViewController *nav = [[ZFNavigationViewController alloc] initWithRootViewController:clsControler];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    return nav;
}

#pragma mark - 设置tabar的代理
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    ///将要选择的item
    ///获取控制器在数组中的索引
    NSInteger index = [self.childViewControllers indexOfObject:viewController];
    ///获取当前索引（重复点击首页的item）
    if (self.selectedIndex == 0 && index == self.selectedIndex) {
        ///让表格滚动到底部，获取到控制器
        UINavigationController *nav = self.childViewControllers[0];
        ZFHomeViewController *vc = (nav.childViewControllers[0]);
        [vc.tableView setContentOffset:CGPointMake(0, -128) animated:YES];
        [vc.refreshController beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc loadData];
        });
    }
    
    return ![viewController isMemberOfClass:[UIViewController class]];
}

///设置显示竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
