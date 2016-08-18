//
//  SJBConment.h
//  小白
//
//  Created by zyyt on 16/7/11.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJBUser.h"


@interface SJBConment : NSObject


/** id */
@property (nonatomic, copy) NSString *ID;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;

/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

/** 用户 */
@property (nonatomic, strong) SJBUser *uSer;

//获取cell的高度
@property (nonatomic,assign)CGFloat cellHeight;

@end
