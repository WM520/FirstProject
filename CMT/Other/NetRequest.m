//
//  NetRequest.m
//  穿名堂
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 zfc. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest

+ (void)sendNetRequestWithUrl:(NSString *)urlStr andDict:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"加载完成"];
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        successBlock(data);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failBlock(error);
        
    }];
}

+ (void)sendNetRequestWithUrl:(NSString *)urlStr successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"加载完成"];
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        
        failBlock(error);
        
    }];
}

@end
