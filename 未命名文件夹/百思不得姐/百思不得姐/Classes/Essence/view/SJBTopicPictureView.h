//
//  SJBTopicPictureView.h
//  小白
//
//  Created by zyyt on 16/7/5.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJBTopicModel;

@interface SJBTopicPictureView : UIView

+ (__kindof SJBTopicPictureView*)pictureView;

@property (nonatomic,strong)SJBTopicModel * topic;

@end
