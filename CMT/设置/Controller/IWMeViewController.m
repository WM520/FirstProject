//
//  IWMeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWMeViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWSystemSettingViewController.h"
#import "Define.h"
#import "CMTLoginViewController.h"

@interface IWMeViewController ()
@end

@implementation IWMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:KCOLOR(29, 38, 34)  forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupHearder];
}

- (void)setupHearder
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREENWIDTH, 250)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"me_background.jpg"];
    self.tableView.tableHeaderView = imageView;
}

- (void)setting
{
    IWSystemSettingViewController *sys = [[IWSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    IWSettingArrowItem *newFriend = [IWSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.operation = ^{
        [self jump];
    };
    group.items = @[newFriend];
}

- (void)jump
{
    CMTLoginViewController *vc = [[CMTLoginViewController alloc] initWithNibName:@"CMTLoginViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *album = [IWSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.operation = ^{
        [self jump];
    };
    IWSettingArrowItem *collect = [IWSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.operation = ^{
        [self jump];
    };
    IWSettingArrowItem *like = [IWSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.operation = ^{
        [self jump];
    };
    group.items = @[album, collect, like];
}



- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *card = [IWSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    card.operation = ^{
        [self jump];
    };
    IWSettingArrowItem *draft = [IWSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    draft.operation = ^{
        [self jump];
    };
    group.items = @[card, draft];
}


@end
