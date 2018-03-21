//
//  ZFBaseViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFBaseViewController.h"
#import "UIBarButtonItem+ZFBarButtonItem.h"

@interface ZFBaseViewController ()

@end

@implementation ZFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

-(void) setupUI{
    self.view.backgroundColor = [UIColor orangeColor];
    //设置不自动缩进
    self.automaticallyAdjustsScrollViewInsets = false;
    [ZFNetworkManager.shared userLogin] ? [self setupTableView] : [self setupVisitorView];
    ///接受登录成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:ZFUserloginSuccessNotification object:nil];
}

-(void) loginSuccess{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.view = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置访客视图
-(void) setupVisitorView{
    UIView *visitorView = [[UIView alloc] initWithFrame:self.view.bounds];
    visitorView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:visitorView];
    
    ///设置导航条按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regist)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
}

-(void) regist{
    NSLog(@"注册");
}

-(void) login{
    [[NSNotificationCenter defaultCenter] postNotificationName:ZFUserShouldLoginNotification object:nil];
}

-(void)loadData{
    [self.refreshController endRefreshing];
}

#pragma mark - 设置tableview
-(void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.refreshController = [[ZFRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshController];
    [self.refreshController addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.tableView];
    ///这句话设置导航栏和tabar不挡住scrollview，并且还有半透明状态
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else{
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
}

#pragma mark - tableview 代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger section = tableView.numberOfSections - 1;
    if(row < 0 || section < 0){
        return;
    }
    
    NSInteger count = [tableView numberOfRowsInSection:section];
    ///如果是最后一行，同时没有上拉刷新
    if(row == (count - 1) && !self.isPullup){
        self.isPullup = YES;
        [self loadData];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
