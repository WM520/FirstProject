//
//  FindModel.h
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface FindModel : JSONModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *describe;

@end
