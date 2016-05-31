//
//  IWSystemSettingViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSystemSettingViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWGeneralViewController.h"
#import "UIImage+Extension.h"
#import "CMTLoginViewController.h"
/** 表格的边框宽度 */
#define IWStatusTableBorder 5


@interface IWSystemSettingViewController ()

@end

@implementation IWSystemSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupFooter];
}

- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = IWStatusTableBorder + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)jump
{
    CMTLoginViewController *vc = [[CMTLoginViewController alloc] initWithNibName:@"CMTLoginViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *account = [IWSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *theme = [IWSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *notice = [IWSettingArrowItem itemWithTitle:@"通知和提醒"];
    IWSettingArrowItem *general = [IWSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[IWGeneralViewController class]];
    IWSettingArrowItem *safe = [IWSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *opinion = [IWSettingArrowItem itemWithTitle:@"意见反馈"];
    opinion.operation = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"意见反馈" message:@"如您在使用过程中遇到任何问题,都可以发邮件到1071597946@qq.com" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    IWSettingArrowItem *about = [IWSettingArrowItem itemWithTitle:@"关于我们"];
    about.operation = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"关于我们" message:@"很荣幸您能使用我的APP,这是一个个人项目,使用过程中如有让您不满意的地方,我感到万分抱歉。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    };
    
    group.items = @[opinion, about];
}

@end