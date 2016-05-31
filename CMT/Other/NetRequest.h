//
//  NetRequest.h
//  穿名堂
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error);


@interface NetRequest : NSObject

+ (void)sendNetRequestWithUrl:(NSString *)urlStr andDict:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

+ (void)sendNetRequestWithUrl:(NSString *)urlStr successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock;

@end
