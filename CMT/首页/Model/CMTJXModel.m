//
//  CMTJXModel.m
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "CMTJXModel.h"

@implementation CMTJXModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"_id":@"ID"}];
}


@end
