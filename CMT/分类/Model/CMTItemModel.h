//
//  CMTItemModel.h
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface CMTItemModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *collocation_type;

@property (nonatomic, copy) NSString<Optional> *big_image;

@property (nonatomic, copy) NSNumber<Optional> *collocation_id;

@property (nonatomic, copy) NSString<Optional> *info;

@property (nonatomic, copy) NSNumber<Optional> *height;

@property (nonatomic, copy) NSNumber<Optional> *width;


@end
