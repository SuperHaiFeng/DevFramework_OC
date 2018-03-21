//
//  UIImageView+WebImage.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

-(void) zf_setImage: (NSString *) urlString placeHolderImage: (UIImage * ) placeHolderImge isAvatar: (BOOL) isAvatar;

@end
