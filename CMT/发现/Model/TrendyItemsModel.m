//
//  TrendyItemsModel.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "TrendyItemsModel.h"

@implementation TrendyItemsModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"description1"}];
}

@end
