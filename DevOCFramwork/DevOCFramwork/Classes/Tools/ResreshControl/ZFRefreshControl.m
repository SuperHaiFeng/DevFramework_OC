//
//  ZFRefreshControl.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/3/1.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFRefreshControl.h"
#import "ZFRefreshView.h"


CGFloat ZFRefreshOffset = 60;

@interface ZFRefreshControl()
///滚动控件的父视图，下拉刷新控件英爱适用于uitableview/uicollectionview
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ZFRefreshView *refreshView;

@end

@implementation ZFRefreshControl

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        if (@available(iOS 11.0, *)) {
            ZFRefreshOffset = kNavigationHeight + 60;
        }
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

///当添加到俯视图的时候，newSubview是父视图
///当父视图被移除，newSubview是nil
-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    ///判断父视图的类型
    if (![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    ///记录父视图
    self.scrollView = (UIScrollView *)newSuperview;
    ///kvo监听父视图的contentOffset
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}

///本视图从父视图上移除
-(void)removeFromSuperview {
    ///superview还存在
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [super removeFromSuperview];
    ///superview不存在
}

///所有的监听都调用该方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    ///contentOffset的y值跟contentInest的top有关
    UIScrollView *sv = self.scrollView;
    if (sv == nil) {
        return;
    }
    
    ///初始化高度
    CGFloat height = -(sv.contentInset.top + sv.contentOffset.y);
    if (height < 0) {
        return;
    }
    ///根据高度刷新控件的frame
    self.frame = CGRectMake(0, -height, sv.bounds.size.width, height);
    
    ///判断理解点
    if (sv.isDragging) {
        if (height > ZFRefreshOffset && self.refreshView.refreshStatu == Normal) {
            self.refreshView.refreshStatu = Pulling;
        }else if (height <= ZFRefreshOffset && self.refreshView.refreshStatu == Pulling){
            self.refreshView.refreshStatu = Normal;
        }
    }else{
        ///放手--判断是否超过临界点
        if (self.refreshView.refreshStatu == Pulling) {
            [self beginRefreshing];
            ///发送刷新事件
            UIEvent *event = [[UIEvent alloc] init];
            for (id target in [self allTargets]) {
                NSArray *actions = [self actionsForTarget:target forControlEvent:UIControlEventValueChanged];
                for (NSString *action in actions) {
                    [self sendAction:NSSelectorFromString(action) to:target forEvent:event];
                }
            }
        }
    }
}

///开始刷新
-(void) beginRefreshing{
    UIScrollView *sv = self.scrollView;
    if (sv == nil) {
        return;
    }
    
    ///判断视图是否正在刷新
    if (self.refreshView.refreshStatu == WillRefresh) {
        return;
    }
    
    ///设置刷新视图的状态
    self.refreshView.refreshStatu = WillRefresh;
    ///调整表格的间距
    UIEdgeInsets inset = sv.contentInset;
    inset.top += ZFRefreshOffset;
    
    sv.contentInset = inset;
}

///结束刷新
-(void) endRefreshing {
    UIScrollView *sv = self.scrollView;
    if (sv == nil) {
        return;
    }
    
    ///判断是否在刷新
    if (self.refreshView.refreshStatu != WillRefresh) {
        return;
    }
    
    ///恢复刷新视图的状态
    self.refreshView.refreshStatu = Normal;
    ///恢复表格视图的contentInset
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = sv.contentInset;
        inset.top -= ZFRefreshOffset;
        sv.contentInset = inset;
    }];
}

-(void) setupUI {
    self.backgroundColor = self.superview.backgroundColor;
    ///超出边界不显示
//    self.clipsToBounds = YES;
    ///添加刷新视图
    [self addSubview:self.refreshView];
    ///自动布局
    self.refreshView.translatesAutoresizingMaskIntoConstraints = NO;
    /**
        ios6或者ios7使用[self addConstraints:@[centerLayout,bottomLaout,widthLayout,heightLayout]];
        ios8以后使用centerLayout.active = YES;
     */
    NSLayoutConstraint *centerLayout = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.0
                                                                    constant:0];
    centerLayout.active = YES;
    NSLayoutConstraint *bottomLaout = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0];
    bottomLaout.active = YES;
    NSLayoutConstraint *widthLayout = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:self.refreshView.bounds.size.width
                                       ];
    widthLayout.active = YES;
    NSLayoutConstraint *heightLayout = [NSLayoutConstraint constraintWithItem:self.refreshView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.0
                                                                     constant:self.refreshView.bounds.size.height];
    heightLayout.active = YES;
    
}


-(ZFRefreshView *)refreshView {
    if (_refreshView == nil) {
        _refreshView = [ZFRefreshView refreshView];
    }
    return _refreshView;
}

@end
