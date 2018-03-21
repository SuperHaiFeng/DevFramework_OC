//
//  ZFNewFeatureView.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFNibLoadable.h"

@interface ZFNewFeatureView : ZFNibLoadable<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageCotrol;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
- (IBAction)enterStatus:(id)sender;

@end
