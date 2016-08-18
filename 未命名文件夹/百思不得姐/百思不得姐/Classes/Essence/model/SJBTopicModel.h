//
//  SJBTopicModel.h
//  小白
//
//  Created by zyyt on 16/7/4.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJBConment.h"

@interface SJBTopicModel : NSObject

@property (nonatomic,copy)NSString * ID;

/*头像的url*/
@property (nonatomic,copy)NSString* profile_image;

/*发帖人的昵称*/
@property (nonatomic,copy)NSString * name;

/*创建时间*/
@property (nonatomic,copy)NSString * created_at;

/*踩得数量*/
@property (nonatomic,assign)NSInteger  hate;

/*顶的数量*/
@property (nonatomic,assign)NSInteger  love;

/*帖子的评论数量*/
@property (nonatomic,assign)NSInteger  comment;

/*帖子的转发数量*/
@property (nonatomic,assign)NSInteger  repost;

/*帖子的文本内容*/
@property (nonatomic,copy)NSString * text;

/* 图片的高度*/
@property (nonatomic,assign)CGFloat  width;

@property (nonatomic,assign)CGFloat height;

/*小图片*/
@property (nonatomic,copy)NSString *  small_image;

/*中国图片*/
@property (nonatomic,copy)NSString * middle_image;

/*大图片*/
@property (nonatomic,copy)NSString * large_image;

//声音帖子的声音源
@property (nonatomic,copy)NSString * voiceuri;

//分享微信时的接口
@property (nonatomic,copy)NSString * weixin_url;

//帖子的类型
@property (nonatomic,assign)SJBTopicType type;

//播放次数
@property (nonatomic,assign)NSInteger   playcount;

//声音时长
@property (nonatomic,assign)NSInteger voicetime;

//视频时长
@property (nonatomic,assign)NSInteger videotime;

//视频源
@property (nonatomic,copy)NSString * videouri;

//最热评论
@property (nonatomic,strong)SJBConment * top_cmt;

/****************************%&%&%&%&%&（+（+（+（+（+（-|》-|》-|》-|》-|》-|》-|》-|》-|》 额外属性 《|-《|-《|-《|-《|-《|-《|-《|-）+）+）+）+）&%&%&%&%&%*********************************/

/*额外添加cell的高度*/
@property (nonatomic,readonly) CGFloat cellHeight;

//图片的frame
@property (nonatomic,readonly)CGRect pictureF;

//声音部分的frame
@property (nonatomic,readonly)CGRect voiceF;

//视频部分的frame
@property (nonatomic,readonly)CGRect videoF;

//图片是否是大图
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;


@end
