//
//  CMTJXCell.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTJXCell.h"
#import "UIImageView+WebCache.h"

@implementation CMTJXCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(CMTJXModel *)model

{
    _model = model;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.descLabel.text = model.title;
    self.priceLabel.text = model.coupon_price;
    self.farLabel.text = model.saveCount;
}

@end
