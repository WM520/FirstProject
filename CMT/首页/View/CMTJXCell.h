//
//  CMTJXCell.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMTJXModel.h"

@interface CMTJXCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *farLabel;


@property (nonatomic, strong) CMTJXModel *model;

@end
