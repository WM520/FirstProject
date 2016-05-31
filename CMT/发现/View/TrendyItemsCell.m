//
//  TrendyItemsCell.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "TrendyItemsCell.h"

@implementation TrendyItemsCell

- (void)awakeFromNib {
    _smallImage.layer.cornerRadius = 10;
    _smallImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
