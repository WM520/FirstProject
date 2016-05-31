//
//  CMTWearModel.h
//  CMT
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 汪淼. All rights reserved.
//

#import "JSONModel.h"

@protocol Match <NSObject>



@end


@interface Match : JSONModel

@property (nonatomic, copy) NSString<Optional> *big_image;

@property (nonatomic, copy) NSNumber<Optional> *collocation_id;

@property (nonatomic, copy) NSString<Optional> *height;

@property (nonatomic, copy) NSString<Optional> *width;

@property (nonatomic, copy) NSString<Optional> *long_info;

@end



@interface CMTWearModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *city_name;

@property (nonatomic, copy) NSString<Optional> *hightemp;

@property (nonatomic, copy) NSString<Optional> *lowtemp;

@property (nonatomic, copy) NSString<Optional> *weather_type;

@property (nonatomic, copy) NSDictionary<Optional, Match> *match;

@end
