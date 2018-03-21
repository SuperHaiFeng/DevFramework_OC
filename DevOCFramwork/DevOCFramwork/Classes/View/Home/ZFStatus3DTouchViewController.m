//
//  ZFStatus3DTouchViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/3/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatus3DTouchViewController.h"
#import "ZFStatusViewModel.h"
#import "ZFStatuses.h"

@interface ZFStatus3DTouchViewController ()

@end

@implementation ZFStatus3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:self.view.bounds];
    lable.text = self.vm.status.text;
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    self.title = @"3D Touch";
    
}

///快捷菜单
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *previewAction0 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:@"置顶" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    return @[previewAction0,previewAction1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
