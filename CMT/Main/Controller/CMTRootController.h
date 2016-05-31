//
//  CMTRootController.h
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@interface CMTRootController : UIViewController


//添加titleView
-(void)addTitleView:(NSString *)name;

//第一个问题，下面的方法的写法，还有好处
//添加左右按钮
-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;
-(void)leftClick:(UIButton *)btn;
-(void)rightClick:(UIButton *)btn;


@end
