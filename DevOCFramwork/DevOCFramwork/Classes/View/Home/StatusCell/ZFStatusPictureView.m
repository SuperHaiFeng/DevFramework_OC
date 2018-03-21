//
//  ZFStatusPictureView.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFStatusPictureView.h"
#import "ZFStatusViewModel.h"
#import "ZFStatusPicture.h"
#import "UIImageView+WebImage.h"

@interface ZFStatusPictureView()

@property (nonatomic, strong) NSArray<ZFStatusPicture *> *urls;

@end

@implementation ZFStatusPictureView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

-(void)setViewModel:(ZFStatusViewModel *)viewModel {
    _viewModel = viewModel;
    [self calcViewSize];
    
    self.urls = viewModel.picURLs;
}

///计算视图的size
-(void) calcViewSize {
    ///处理宽度
    ///1》单图根据配图视图大小，修改subviews[0]的宽高
    if (_viewModel.picURLs.count == 1) {
        CGSize viewSize = _viewModel.pictureViewSize;
        UIView *v = self.subviews[0];
        v.frame = CGRectMake(0,
                             ZFStatusPictureViewOutterMargin,
                             viewSize.width,
                             viewSize.height - ZFStatusPictureViewOutterMargin);
        
    }else{
        ///2》多图，恢复subviews[0]的宽高，保证九宫格布局的完成
        UIView *v = self.subviews[0];
        v.frame = CGRectMake(0,
                             ZFStatusPictureViewOutterMargin,
                             ZFStatusPictureItemWidth,
                             ZFStatusPictureItemWidth);
    }
    _heightCons.constant = _viewModel.pictureViewSize.height;
}

-(void)setUrls:(NSArray<ZFStatusPicture *> *)urls {
    _urls = urls;
    ///隐藏所有imageview
    for (UIView *v in self.subviews) {
        [v setHidden:YES];
    }
    
    int index = 0;
    for (ZFStatusPicture *url in urls) {
        UIImageView *iv = self.subviews[index];
        ///处理四张图像
        if (index == 1 && urls.count == 4) {
            index += 1;
        }
        [iv zf_setImage:url.thumbnail_pic placeHolderImage:nil isAvatar:NO];
        [iv setHidden:NO];
        index += 1;
    }
}

-(void) setupUI {
    ///超出边界的内容不显示
    self.clipsToBounds = YES;
    int count = 3;
    CGRect rect = CGRectMake(0,
                             ZFStatusPictureViewOutterMargin,
                             ZFStatusPictureItemWidth,
                             ZFStatusPictureItemWidth);
    ///循环创建9个imageview
    for (int i = 0; i < count * count; i++) {
        UIImageView *iv = [UIImageView new];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = YES;
        ///行
        int row = i / count;
        ///列
        int col = i % count;
        
        CGFloat xOffset = col * (ZFStatusPictureItemWidth + ZFStatusPictureViewInnerMargin);
        CGFloat yOffset = row * (ZFStatusPictureItemWidth + ZFStatusPictureViewInnerMargin);
        
        iv.frame = CGRectOffset(rect, xOffset, yOffset);
        [self addSubview:iv];
    }
}

@end
