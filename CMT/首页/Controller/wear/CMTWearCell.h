//
//  CMTWearCell.h
//  CMT
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import <UIKit/UIKit.h>






@interface CMTWearCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@property (weak, nonatomic) IBOutlet UILabel *day;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;




@end
