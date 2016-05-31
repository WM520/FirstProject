//
//  FineStreetViewController2.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "CMTRootController.h"
typedef void(^ChangeView)(id);
@interface FineStreetViewController2 : CMTRootController

@property (nonatomic, copy) ChangeView changBlock;

@end
