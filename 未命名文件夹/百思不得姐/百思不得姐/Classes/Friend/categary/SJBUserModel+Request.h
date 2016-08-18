//
//  SJBUserModel+Request.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBUserModel.h"

typedef void(^Success)(NSArray*arr);
//typedef void  (^Success)(NSArray *,NSInteger);

typedef void(^Fail)(NSError * err);

@interface SJBUserModel (Request)
+ (void)requestWithURL:(NSString*)urlStr params:(NSDictionary*)dict success:(Success)success fail:(Fail)fail;

@end
