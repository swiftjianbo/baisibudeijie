//
//  SJBCategaryModel+Request.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBCategaryModel+Request.h"

@implementation SJBCategaryModel (Request)

+ (void)requestWithURL:(NSString *)urlStr params:(NSDictionary *)dict success:(Success)success fail:(Fail)fail
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        
//        NSArray * arr = [SJBCategaryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSMutableArray * arr = [NSMutableArray array];
        for (int i=0; i< [responseObject[@"list"] count]; i++) {
            SJBCategaryModel * model = [[SJBCategaryModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject[@"list"][i]];
            [arr addObject:model];
        }
        SJBLog(@"%@",arr);
        NSArray * array = [[NSArray alloc] initWithArray:arr];
        success(array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

@end
