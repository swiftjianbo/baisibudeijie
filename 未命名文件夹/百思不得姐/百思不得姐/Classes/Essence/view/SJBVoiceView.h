//
//  SJBVideoView.h
//  小白
//
//  Created by zyyt on 16/7/8.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJBTopicModel;

@interface SJBVoiceView : UIView

@property (nonatomic,strong)SJBTopicModel * topic;

+ (instancetype)voiceView;

-(void)reset;

@end
