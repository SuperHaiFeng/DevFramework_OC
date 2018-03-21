//
//  ZFDemoViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFDemoViewController.h"
#import "UIBarButtonItem+ZFBarButtonItem.h"

@interface ZFDemoViewController ()

@end

@implementation ZFDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%lu",self.navigationController.childViewControllers.count];
    
}

-(void) setupTableView{
    [super setupTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init:@"下一个" fontSize:16 image:nil horizontalAlignment:UIControlContentHorizontalAlignmentRight target:self action:@selector(showNext)];
}

-(void) showNext {
    ZFDemoViewController *demo = [ZFDemoViewController new];
    [self.navigationController pushViewController:demo animated:YES];
}

@end
