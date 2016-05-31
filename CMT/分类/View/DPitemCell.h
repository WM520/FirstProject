//
//  DPitemCell.h
//  穿名堂
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 zfc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DPitemModel.h"
@interface DPitemCell : UITableViewCell

@property (nonatomic,strong) DPitemModel *model;

+(instancetype)cellInitWithTableView:(UITableView *)tableView;
+(CGFloat)cellHight;

@end
