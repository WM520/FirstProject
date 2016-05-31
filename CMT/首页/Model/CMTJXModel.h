//
//  CMTJXModel.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface CMTJXModel : JSONModel

@property (nonatomic, copy) NSNumber<Optional> *ID;
@property (nonatomic, copy) NSString<Optional> *coupon_price;
@property (nonatomic, copy) NSString<Optional> *saveCount;
@property (nonatomic, copy) NSString<Optional> *price;
@property (nonatomic, copy) NSString<Optional> *pic_url;
@property (nonatomic, copy) NSString<Optional> *title;




@end
