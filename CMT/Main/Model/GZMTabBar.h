//
//  GZMTabBar.h
//  playWeek
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZMTabBar;

@protocol GZMTabBarDelegate <NSObject>

- (void)tabBar:(GZMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end



@interface GZMTabBar : UIView

- (void)addTabBarItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<GZMTabBarDelegate> delegate;

@end
