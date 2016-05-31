//
//  DressSchoolModel.h
//  CMT
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@interface DressSchoolModel : JSONModel

@property (nonatomic,copy) NSNumber <Optional>*dress_school_id;
@property (nonatomic,copy) NSString <Optional>*image;
@property (nonatomic,copy) NSString <Optional>*info;
@property (nonatomic,copy) NSString <Optional>*link;
@property (nonatomic,copy) NSString <Optional>*title;

@end
