//
//  ZFNavigationViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNavigationViewController.h"

@interface ZFNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZFNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationBar setHidden:YES];
    self.navigationBar.tintColor = [UIColor orangeColor];
}

/** 重写push方法*/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        if(viewController){
            NSString *title = @"返回";
            if(self.viewControllers.count == 1){
                title = self.viewControllers.firstObject.title;
            }
            UIBarButtonItem *item = [[UIBarButtonItem alloc] init:title fontSize:16 image:[UIImage imageNamed:@"back"] horizontalAlignment:UIControlContentHorizontalAlignmentLeft target:self action:@selector(popToParent)];
            viewController.navigationItem.leftBarButtonItem = item;
        }
    }
    [super pushViewController:viewController animated:animated];
}

-(void) popToParent{
    [self popViewControllerAnimated:true];
}

@end
