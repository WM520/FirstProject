//
//  TrendyItemsCell.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendyItemsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *smallImage;

@end
