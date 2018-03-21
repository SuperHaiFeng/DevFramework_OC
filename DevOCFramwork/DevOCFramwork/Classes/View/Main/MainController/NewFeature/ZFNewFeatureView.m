//
//  ZFNewFeatureView.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNewFeatureView.h"

@implementation ZFNewFeatureView

-(void)awakeFromNib {
    [super awakeFromNib];
    ///自动布局设置的页面，从xib加载默认
    int count = 4;
    CGRect rect = [UIScreen mainScreen].bounds;
    for (int i = 0; i < count; i++) {
        NSString *imageName = @"feature";
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        iv.frame = CGRectMake(i * rect.size.width, 0, rect.size.width, rect.size.height);
        [self.scrollView addSubview:iv];
        
    }
    
    self.scrollView.contentSize = CGSizeMake((count + 1) * rect.size.width, rect.size.height);
    self.scrollView.bounces = false;
    [self.scrollView setPagingEnabled:true];
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.delegate = self;
    [self.enterButton setHidden:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    ///滚动到最后一个，删除视图
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    ///判断是否是最后一页
    if (page == scrollView.subviews.count) {
        [self removeFromSuperview];
    }
    
    [self.enterButton setHidden:page != scrollView.subviews.count - 1];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    self.pageCotrol.currentPage = page;
    [self.pageCotrol setHidden:page == scrollView.subviews.count];
}


- (IBAction)enterStatus:(id)sender {
    [self removeFromSuperview];
}
@end
