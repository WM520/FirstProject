//
//  WebController.m
//  穿名堂
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import "WebController.h"
#import "Define.h"
#import "MBProgressHUD+MJ.h"

@interface WebController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *_flower;
}
@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
- (void)createUI{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, KSCREENWIDTH, KSCREENHEIGHT-100)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
         [self.webView loadRequest:request];
    });
    [self.view addSubview:self.webView];
    _flower = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _flower.frame = CGRectMake(100, 100, 100, 100);

    _flower.center = self.webView.center;
   
    _flower.color = [UIColor blackColor];
    
    [_flower startAnimating];
    
    [self.view addSubview:_flower];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD showError:@"网页请求错误"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_flower stopAnimating];
}
@end
