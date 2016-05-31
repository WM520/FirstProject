//
//  DPitemCell.m
//  穿名堂
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import "DPitemCell.h"
#import "UIView+Extension.h"
#import "Define.h"
#import "UIImageView+WebCache.h"

@interface DPitemCell ()
{
    UIImageView *_imageView;
    UILabel *_descriptionLB;
    UILabel *_titleLB;
    UILabel *_coupon_priceLB;
    UILabel *_priceLB;
    UIView *_lineView;
    UIImageView *_turnIV;
}

@end

@implementation DPitemCell

+(instancetype)cellInitWithTableView:(UITableView *)tableView{
    static NSString *ID = @"dpItemCell";
    DPitemCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[DPitemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    
    return cell;
    
}

+(CGFloat)cellHight{
    return 60;
}

- (void)addSubviews{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 58, 58)];
    [self.contentView addSubview:_imageView];
    
    _descriptionLB = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.maxX+kMargin/2, 2, 40, 26)];
    [self.contentView addSubview:_descriptionLB];
    
    _titleLB = [[UILabel alloc ]initWithFrame:CGRectMake(_descriptionLB.maxX+kMargin, 2, KSCREENWIDTH-_descriptionLB.maxY-4*kMargin, 26)];
    [self.contentView addSubview:_titleLB];
    
    _coupon_priceLB = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.maxX+kMargin/2, _descriptionLB.maxY+2, 70, 26)];
    [self.contentView addSubview:_coupon_priceLB];
    
    _priceLB = [[UILabel alloc]initWithFrame:CGRectMake(_coupon_priceLB.maxX+kMargin, _descriptionLB.maxY+2, 70, 26)];
    [self.contentView addSubview:_priceLB];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_coupon_priceLB.maxX+kMargin/2, _descriptionLB.maxY+15, 65, 1)];
    
    [self.contentView addSubview:_lineView];
    
    _turnIV = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLB.maxX+kMargin, 15, 30, 30)];
    [self.contentView addSubview:_turnIV];
}

- (void)setModel:(DPitemModel *)model{
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    
    _descriptionLB.text = model.description1;
    _descriptionLB.textColor = kdpBtnColor;
    
    _titleLB.text = model.title;
    _titleLB.textColor = [UIColor grayColor];
    _titleLB.numberOfLines = 1;
    _titleLB.font = kFont(12);
    
    _coupon_priceLB.text = model.coupon_price;
    _coupon_priceLB.textColor = [UIColor redColor];
    
    _priceLB.text = model.price;
    _priceLB.textColor = [UIColor grayColor];
    
    _turnIV.image = [UIImage imageNamed:@"turn@3x"];
    
    _lineView.backgroundColor = [UIColor grayColor];
}

@end
