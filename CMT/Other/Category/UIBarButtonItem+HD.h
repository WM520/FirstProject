//
//  UIBarButtonItem+HD.h
//  1520WM-网络
//
//  Created by qianfeng on 15/12/11.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HD)


+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon target:(id)target action:(SEL)action;


@end
