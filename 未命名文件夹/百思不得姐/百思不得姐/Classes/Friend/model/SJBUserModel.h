//
//  SJBUserModel.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBUserModel : NSObject

@property (nonatomic,copy)NSString * uid;
@property (nonatomic,copy)NSString * screen_name;
@property (nonatomic,copy)NSString * introduction;
/*注释*/
@property (nonatomic,assign)NSInteger fans_count;
/*注释*/
@property (nonatomic,assign)NSInteger tiezi_count;
/*<#注释#>*/
@property (nonatomic,copy)NSString *header;
/*注释*/
@property (nonatomic,assign)NSInteger gender;
/*<#注释#>*/
@property (nonatomic,assign)NSInteger is_follow;

@end
