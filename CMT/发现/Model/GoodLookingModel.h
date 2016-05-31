//
//  GoodLookingModel.h
//  CMT
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface GoodLookingModel : JSONModel

@property (nonatomic,copy) NSString <Optional>*nick_name;
@property (nonatomic,copy) NSString <Optional>*head_pic;
@property (nonatomic,copy) NSString <Optional>*create_time;
@property (nonatomic,copy) NSString <Optional>*image;
@property (nonatomic,copy) NSString <Optional>*like_count;
@property (nonatomic,copy) NSString <Optional>*comment;
@property (nonatomic,copy) NSString <Optional>*haokanme_id;



@end
