//
//  CMTNewWebController.m
//  CMT
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTNewWebController.h"
#import "UIBarButtonItem+HD.h"
#include "Define.h"

@interface CMTNewWebController ()

{
    UIWebView *_webView;
}

@end

@implementation CMTNewWebController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"攻略详情";
    self.view.userInteractionEnabled = YES;
    [self configUI];
}

- (void)configUI
{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT)];
    _webView.userInteractionEnabled = YES;
    [self.view addSubview:_webView];
    NSString *url = self.url;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}





@end
