//
//  CMTReusableView.m
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "CMTReusableView.h"

@implementation CMTReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, 20)];
        self.title.font = [UIFont boldSystemFontOfSize:15];
        
        [self addSubview:self.title];
    }
    return self;
}



@end
