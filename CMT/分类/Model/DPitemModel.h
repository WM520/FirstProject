//
//  DPitemModel.h
//  穿名堂
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPitemModel : NSObject
@property (nonatomic,strong) NSString *description1;
@property (nonatomic,strong) NSString *title ;
@property (nonatomic,strong) NSString *coupon_price;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *item_id;
@property (nonatomic,strong) NSString *pic_url;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
