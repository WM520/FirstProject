//
//  CMTItemCell.m
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "CMTItemCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "Define.h"

@interface CMTItemCell ()

@property (weak, nonatomic) UIImageView *backImageView;
@end


@implementation CMTItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configCell];
    }
    return self;
}

- (void)configCell
{
    __weak typeof(&*self) ws = self;
    // 0.大的背景图片
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.layer.masksToBounds = YES;
    [self.contentView addSubview:backImage];
    self.backImageView = backImage;
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView);
        make.right.equalTo(ws.contentView);
        make.bottom.equalTo(ws.contentView);
    }];
    
    // 1.图片
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleToFill;
    self.imgView = imgView;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(ws.contentView).offset(0);
        make.left.equalTo(ws.contentView).offset(0);
        make.right.equalTo(ws.contentView).offset(0);
    }];
    
    // 2.描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.textColor = [UIColor orangeColor];
    self.descLabel = descLabel;
    [self.contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(2);
        make.left.equalTo(ws.contentView).offset(2);
        make.right.equalTo(ws.contentView).offset(2);
    }];
    
    // 3.style
    UILabel *styleLabel = [[UILabel alloc] init];
    styleLabel.textColor = KCOLOR(151, 133, 185);
    styleLabel.font = [UIFont systemFontOfSize:12];
    self.styleLabel = styleLabel;
    [self.contentView addSubview:styleLabel];
    [styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLabel.mas_bottom).offset(2);
        make.left.equalTo(descLabel);
        make.right.equalTo(descLabel);
        make.bottom.equalTo(ws.contentView).offset(-2);
    }];
}

- (void)setModel:(CMTItemModel *)model
{
    _model = model;
    self.backImageView.image = [UIImage imageNamed:@"appdetail_background"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.big_image]];
    self.descLabel.text = model.info;
    self.styleLabel.text = model.collocation_type;
}


@end
