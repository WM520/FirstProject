//
//  CMTHeader.h
//  CMT
//
//  Created by qianfeng on 15/12/23.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface CMTHeader : JSONModel

@property (nonatomic, copy) NSNumber<Optional> *theme_id;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *theme_name;
@property (nonatomic, copy) NSString<Optional> *theme_image;
@property (nonatomic, copy) NSString<Optional> *theme_desc;
@property (nonatomic, copy) NSString<Optional> *theme_link;

@end
