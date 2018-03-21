//
//  UIImage+Extention.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

-(UIImage *) zf_avatarImage: (CGSize) size backColor: (UIColor *) backColor lineColor: (UIColor *) lineColor{
    CGSize size1 = size;
    
    CGRect rect = CGRectMake(0, 0, size1.width, size1.height);
    
    UIGraphicsBeginImageContextWithOptions(size1, YES, 0);
    
    [backColor setFill];
    UIRectFill(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    
    [self drawInRect:rect];
    
    UIBezierPath *ovalpath = [UIBezierPath bezierPathWithOvalInRect:rect];
    ovalpath.lineWidth = 2;
    [lineColor setStroke];
    [ovalpath stroke];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
    
}

@end
