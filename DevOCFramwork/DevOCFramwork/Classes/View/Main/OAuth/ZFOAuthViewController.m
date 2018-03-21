//
//  ZFOAuthViewController.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFOAuthViewController.h"
#import "UIBarButtonItem+ZFBarButtonItem.h"
#import <SVProgressHUD.h>

@interface ZFOAuthViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webview;

@end

@implementation ZFOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webview];
    self.webview.delegate = self;

    self.title = @"登录微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init:@"返回" fontSize:16 image:nil horizontalAlignment:UIControlContentHorizontalAlignmentLeft target:self action:@selector(close)];

    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",AppKey,RedirectURI];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.absoluteString hasPrefix:RedirectURI] == NO) {
        return YES;
    }
    
    if ([request.URL.query hasPrefix:@"code="] == NO) {
        [self close];
        return NO;
    }
    
    [self close];
    NSRange range = [request.URL.query rangeOfString:@"code="];
    ///获取授权码
    if (range.location != NSNotFound) {
        NSString *code = [request.URL.query substringFromIndex:range.location + range.length];
        __weak typeof(self) weakself = self;
        [ZFNetworkManager.shared loadAccessToken:code completion:^(BOOL isSuccess) {
            if (isSuccess) {
                [NSNotificationCenter.defaultCenter postNotificationName:ZFUserloginSuccessNotification object:nil];
                [weakself close];
            }else{
                [SVProgressHUD showInfoWithStatus:@"网络请求失败"];
            }
        }];
    }
    return NO;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}


-(void) close {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
