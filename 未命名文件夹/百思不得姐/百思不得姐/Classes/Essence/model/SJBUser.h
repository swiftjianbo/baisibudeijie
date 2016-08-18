//
//  SJBUser.h
//  小白
//
//  Created by zyyt on 16/7/11.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBUser : NSObject

/*
 * 用户名 
 */
@property (nonatomic, copy) NSString *username;

/*
 * 性别 
 */
@property (nonatomic, copy) NSString *sex;

/*
 * 头像
 */
@property (nonatomic, copy) NSString *profile_image;

@end
