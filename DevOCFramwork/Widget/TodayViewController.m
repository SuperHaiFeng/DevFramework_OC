//
//  TodayViewController.m
//  Widget
//
//  Created by 志方 on 2018/3/7.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property(nonatomic, strong) UIButton *btn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(10, 10, 50, 40);
    [self.btn setTitle:@"播放" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) play {
    [self.extensionContext openURL:[NSURL URLWithString:@"duobao.DevOCFramwork://action=richScan"] completionHandler:^(BOOL success) {
        NSLog(@"打开");
    }];
}

///取数据
-(NSString *) widgetStringForKey: (NSString *) defaultName{
    NSUserDefaults *share = [[NSUserDefaults alloc] initWithSuiteName:@"duobao.DevOCFramwork"];
    return [share stringForKey:defaultName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    if (@available(iOS 10.0, *)) {
        if (activeDisplayMode == NCWidgetDisplayModeCompact) {
            ///尺寸只设置高度即可，宽度是固定的
            self.preferredContentSize = CGSizeMake(0, 110);
        }else{
            self.preferredContentSize = CGSizeMake(0, 310);
        }
    } else {
        // Fallback on earlier versions
    }
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

@end
