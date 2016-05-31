//
//  CMTItemCell.h
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTItemModel.h"
@interface CMTItemCell : UICollectionViewCell


@property (strong, nonatomic) CMTItemModel *model;

@property (weak, nonatomic) UIImageView *imgView;
@property (weak, nonatomic) UILabel *descLabel;
@property (weak, nonatomic) UILabel *styleLabel;
@end
