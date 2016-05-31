//
//  CMTTabBarController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTTabBarController.h"
#import "CMTHomeController.h"
#import "CMTGroupController.h"
#import "CMTFindController.h"
#import "IWMeViewController.h"
#import "CMTMainController.h"
#import "UIImage+Extension.h"
#import "GZMTabBar.h"
#import "GZMTarButton.h"

@interface CMTTabBarController ()
@property (nonatomic, strong) GZMTabBar *customBar;
@end

@implementation CMTTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *childsView in self.tabBar.subviews) {
        if ([childsView isKindOfClass:[UIControl class]]) {
            [childsView removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    [self setupAllClildViews];
}

- (void)setupTabBar
{
    GZMTabBar *tabBar = [[GZMTabBar alloc] init];
    tabBar.delegate = self;
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    self.customBar = tabBar;
}

- (void)setupAllClildViews
{
    // 1.首页
    CMTHomeController *home = [[CMTHomeController alloc]init];
    [self setupChildViewController:home title:@"精选" imageName:@"tab_bar_home_icon" selectedImageName:@"tab_bar_home_icon_current"];
    // 2.搭配
    CMTGroupController *only = [[CMTGroupController alloc] init];
    [self setupChildViewController:only title:@"搭配" imageName:@"tab_bar_around_icon" selectedImageName:@"tab_bar_around_icon_current"];
    // 3.发现
    CMTFindController *cls = [[CMTFindController alloc] init];
    [self setupChildViewController:cls title:@"发现" imageName:@"tab_bar_discover_icon" selectedImageName:@"tab_bar_discover_icon_current"];
    // 4.me
    IWMeViewController *me = [[IWMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tab_bar_my_icon" selectedImageName:@"tab_bar_my_icon_current"];
    
}

#pragma mark -GZMTabBarDelegate
- (void)tabBar:(GZMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}


- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    // 2.包装一个导航控制器
    CMTMainController *nav = [[CMTMainController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customBar addTabBarItem:childVc.tabBarItem];
}


@end
