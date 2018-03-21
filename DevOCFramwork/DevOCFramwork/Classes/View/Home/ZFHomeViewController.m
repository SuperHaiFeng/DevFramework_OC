//
//  ZFHomeViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/1/31.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFHomeViewController.h"
#import "UIBarButtonItem+ZFBarButtonItem.h"
#import "ZFDemoViewController.h"
#import "ZFStatusedList_ViewModel.h"
#import "ZFStatuses.h"
#import "ZFStatusCell.h"
#import "ZFStatusViewModel.h"
#import "ZFStatus3DTouchViewController.h"

///原创id
NSString *originalCellId = @"originalCellId";
///被转发可重用的id
NSString *retweetedCellId = @"retweetedCellId";

@interface ZFHomeViewController ()<UIViewControllerPreviewingDelegate>
{
    CGFloat beginContentY;
    CGFloat endContentY;
}

@property(nonatomic, strong) ZFStatusedList_ViewModel *listViewModel;

@end

@implementation ZFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void) setupTableView{
    [super setupTableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init:@"好友" fontSize:16 image:nil horizontalAlignment:UIControlContentHorizontalAlignmentLeft target:self action:@selector(showFriends)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZFStatusNormalCell" bundle:nil] forCellReuseIdentifier:originalCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZFStatusRetweetedCell" bundle:nil] forCellReuseIdentifier:retweetedCellId];
    ///自动布局的时候使用
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - 加载数据
-(void)loadData{
    __weak typeof(self) weakself = self;
    [self.listViewModel loadStatus:self.isPullup completion:^(BOOL isSuccess, BOOL shouldRefresh) {
        [weakself.refreshController endRefreshing];
        weakself.isPullup = NO;
        if (shouldRefresh) {
            [weakself.tableView reloadData];
        }
    }];
}

#pragma mark tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listViewModel.statusList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFStatusViewModel *vm = self.listViewModel.statusList[indexPath.row];
    NSString *cellId = vm.status.retweeted_status == nil ? originalCellId : retweetedCellId;
    ZFStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.viewModel = vm;
    
    /** 注册3D Touch
     从iOS9开始，我们可以通过这个类来判断运行程序对应的设备是否支持3D Touch功能。 UIForceTouchCapabilityUnknown = 0, //未知
     UIForceTouchCapabilityUnavailable = 1, //不可用
     UIForceTouchCapabilityAvailable = 2 //可用
     */
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:cell];
            }
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFStatusViewModel *vm = self.listViewModel.statusList[indexPath.row];
    return vm.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setNavigationBarFromY:kNavigationHeight - 44];
    ZFStatusViewModel *vm = self.listViewModel.statusList[indexPath.row];
    ZFStatus3DTouchViewController *presentVC = [[ZFStatus3DTouchViewController alloc] init];
    presentVC.vm = vm;
    [self.navigationController pushViewController:presentVC animated:YES];
}

#pragma mark - UIViewControllerPreviewingDelegate  监听3D Touch触发
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(ZFStatusCell *)[previewingContext sourceView]];
    ZFStatusViewModel *vm = self.listViewModel.statusList[indexPath.row];
    [self setNavigationBarFromY:kNavigationHeight - 44];
    
    ///创建要预览的控制器
    ZFStatus3DTouchViewController *presentVC = [[ZFStatus3DTouchViewController alloc] init];
    presentVC.vm = vm;
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    previewingContext.sourceRect = rect;
    
    return presentVC;
}

///3D Touch跳转pop
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}

///设置导航栏的隐藏和显示
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beginContentY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    endContentY = scrollView.contentOffset.y;
    if (endContentY - beginContentY > 80) {
        if (self.navigationController.navigationBar.frame.origin.y == -44) {
            return;
        }
        [self setNavigationBarFromY:-44];
    }else if (endContentY - beginContentY < -80){
        if (self.navigationController.navigationBar.frame.origin.y == (kNavigationHeight - 44)) {
            return;
        }
        [self setNavigationBarFromY:kNavigationHeight - 44];
    }
    if (scrollView.contentOffset.y <= 60) {
        [self setNavigationBarFromY:kNavigationHeight - 44];
    }
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    [self setNavigationBarFromY:kNavigationHeight - 44];
}

-(void) setNavigationBarFromY: (CGFloat) y {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = self.navigationController.navigationBar.frame;
        rect.origin.y = y;
        self.navigationController.navigationBar.frame = rect;
    }];
}

-(void) showFriends {
    ZFDemoViewController *demo = [ZFDemoViewController new];
    [self.navigationController pushViewController:demo animated:YES];
}

-(ZFStatusedList_ViewModel *)listViewModel {
    if (_listViewModel == nil) {
        _listViewModel = [ZFStatusedList_ViewModel new];
    }
    return _listViewModel;
}

@end
