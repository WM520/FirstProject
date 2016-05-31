//
//  CMTRootController.m
//  CMT
//
//  Created by qianfeng on 16/12/17.
//  Copyright (c) 2016年 汪淼. All rights reserved.
//

#import "CMTRootController.h"

@interface CMTRootController ()

@end

@implementation CMTRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addTitleView:(NSString *)name{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150*KRATE, 44)];
    label.textColor= [UIColor blackColor];
    label.text=name;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    self.navigationItem.titleView=label;
}

-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44*KRATE, 30)];
    if (title!=nil) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    if (backGroundImage!=nil) {
        [btn setBackgroundImage:[UIImage imageNamed:backGroundImage] forState:UIControlStateNormal];
    }
    UIBarButtonItem *barBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    if ([direction isEqualToString:KLEFTNAVBAR]) {
        [btn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=barBtn;
    }else if([direction isEqualToString:KRIGHTNACBAR]){
        [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
}

-(void)leftClick:(UIButton *)btn{
    NSLog(@"子类需要重写leftClick:方法");
}
-(void)rightClick:(UIButton *)btn{
    NSLog(@"子类需要重写rightClick:方法");
}

@end
