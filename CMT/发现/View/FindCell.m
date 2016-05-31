//
//  FindCell.m
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "FindCell.h"

@implementation FindCell

- (void)awakeFromNib {
    // Initialization code
    _image.layer.cornerRadius = 5;
    _image.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
