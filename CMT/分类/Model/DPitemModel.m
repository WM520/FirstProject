//
//  DPitemModel.m
//  穿名堂
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import "DPitemModel.h"

@implementation DPitemModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if(self=[super init]){
        _item_id=dict[@"item_id"];
        _title=dict[@"title"];
        _coupon_price=dict[@"coupon_price"];
        _price=dict[@"price"];
        _pic_url=dict[@"pic_url"];
        _description1=dict[@"description"];
    }
    return self;
}
@end
