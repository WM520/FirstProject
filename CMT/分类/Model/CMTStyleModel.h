//
//  CMTStyleModel.h
//  CMT
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface CMTStyleModel : JSONModel


@property (nonatomic, copy) NSString<Optional> *classify_icon;

@property (nonatomic, copy) NSNumber<Optional> *classify_id;

@property (nonatomic, copy) NSString<Optional> *classify_name;

@end
