//
//  SJBUserModel+Request.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBUserModel+Request.h"

@implementation SJBUserModel (Request)

+ (void)requestWithURL:(NSString *)urlStr params:(NSDictionary *)dict success:(Success)success fail:(Fail)fail
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);

        NSMutableArray * arr = [NSMutableArray array];
        for (int i=0; i< [responseObject[@"list"] count]; i++) {
            SJBUserModel * model = [[SJBUserModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject[@"list"][i]];
            [arr addObject:model];
        }
        SJBLog(@"%@",arr);
        NSArray * array = [[NSArray alloc] initWithArray:arr];
//        success(array,@([[responseObject objectForKey:@"total"] integerValue]));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}


@end
