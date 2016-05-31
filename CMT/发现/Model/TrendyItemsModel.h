//
//  TrendyItemsModel.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface TrendyItemsModel : JSONModel

@property (nonatomic,copy) NSNumber <Optional>*_id;
@property (nonatomic,copy) NSString <Optional>*saveCount;
@property (nonatomic,copy) NSString <Optional>*icon_type;
@property (nonatomic,copy) NSString <Optional>*pic_url;
@property (nonatomic,copy) NSString <Optional>*description1;
@property (nonatomic,copy) NSString <Optional>*title;
@property (nonatomic,copy) NSString <Optional>*price;


@end
