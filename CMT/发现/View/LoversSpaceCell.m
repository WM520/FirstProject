//
//  LoversSpaceCell.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "LoversSpaceCell.h"

@implementation LoversSpaceCell

- (void)awakeFromNib {
    _image.layer.cornerRadius = 5;
    _image.layer.masksToBounds = YES;
}

@end
