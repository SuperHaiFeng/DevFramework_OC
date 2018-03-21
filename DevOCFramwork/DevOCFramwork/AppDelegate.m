//
//  AppDelegate.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "AppDelegate.h"
#import "ZFMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ZFMainViewController alloc] init];;
    [self.window makeKeyAndVisible];
    
    ///取得用户授权显示通知
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    
    [self loadAppInfo];
    
//    NSMutableArray *arrShortcutItems = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
//    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"duobao.DevOCFramwork.openSearch" localizedTitle:@"搜索" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
//    [arrShortcutItems addObject:shoreItem1];
//    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"duobao.DevOCFramwork.openCompose" localizedTitle:@"新消息" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
//    [arrShortcutItems addObject:shoreItem2];
    
    return YES;
}


#pragma mark - 模拟从服务器加载应用程序信息
-(void) loadAppInfo{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [[NSBundle mainBundle] pathForResource:@"main.json" ofType:nil];
        NSData *data = [[NSData alloc] initWithContentsOfFile:url];
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *jsonPath = [docDir stringByAppendingPathComponent:docDir];
        ///保存到沙盒使用
        [data writeToFile:jsonPath atomically:YES];
    });
}

#pragma mark - 监听3D Touch点击的选项
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"name:%@\ntype:%@", shortcutItem.localizedTitle, shortcutItem.type);
}

///保存widget使用的数据
-(void) widgetSetObject: (id) value forKey: (NSString *) defaultName{
    NSUserDefaults *share = [[NSUserDefaults alloc] initWithSuiteName:@"duobao.DevOCFramwork"];
    [share setObject:value forKey:defaultName];
    [share synchronize];
}


@end
