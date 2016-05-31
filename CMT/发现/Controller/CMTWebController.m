//
//  CMTWebController.m
//  CMT
//
//  Created by qianfeng on 15/12/23.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTWebController.h"
#import "UIBarButtonItem+HD.h"
#import "UMSocial.h"

@interface CMTWebController () <UIWebViewDelegate, UMSocialUIDelegate>
{
     UIWebView *_webView;
}
@end

@implementation CMTWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"攻略详情";
    [self configUI];
}

- (void)configUI
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSString *url = [NSString stringWithFormat:KDRESSURL, [self.ID integerValue]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    _webView.delegate = self;
    [_webView loadRequest:request];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"ic_setting_share_app" selectedIcon:@"ic_setting_share_app" target:self action:@selector(share)];
}

// 分享
- (void)share
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:KUMKEY shareText:@"这样的搭配好帅" shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:@[UMShareToSina,UMShareToFacebook, UMShareToEmail] delegate:self];
}


@end
