//
//  CMTUserComment.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface CMTUserComment : JSONModel

@property (nonatomic, copy) NSString<Optional> *content;

@property (nonatomic, copy) NSString<Optional> *name;


@end
