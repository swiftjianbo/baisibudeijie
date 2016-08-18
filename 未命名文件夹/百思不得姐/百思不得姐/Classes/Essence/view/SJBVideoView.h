//
//  SJBVideoView.h
//  小白
//
//  Created by zyyt on 16/7/8.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>



@class SJBTopicModel;

@protocol SJBVideoViewDelegate <NSObject>

- (void)playWithTopic:(SJBTopicModel*)topic;

@end

@interface SJBVideoView : UIView

@property (nonatomic,strong)SJBTopicModel * topic;

@property (nonatomic,weak)id<SJBVideoViewDelegate>videoDelegate;

+ (instancetype)videoView;

- (void)reset ;


@end
