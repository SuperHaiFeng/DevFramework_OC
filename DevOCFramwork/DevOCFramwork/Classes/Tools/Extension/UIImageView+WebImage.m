//
//  UIImageView+WebImage.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Extention.h"

@implementation UIImageView (WebImage)

-(void) zf_setImage: (NSString *) urlString placeHolderImage: (UIImage * ) placeHolderImge isAvatar: (BOOL) isAvatar{
    ///隔离SDWebImage设置图像函数
    ///如果是头像，则给圆角
    NSURL *url = [NSURL URLWithString:urlString];
    __weak typeof(self) weakself = self;
    [self sd_setImageWithURL:url placeholderImage:placeHolderImge options:SDWebImageLowPriority progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (isAvatar) {
            weakself.image = [image zf_avatarImage:self.bounds.size backColor:[UIColor whiteColor] lineColor:[UIColor grayColor]];
        }
    }];
    
}



@end
