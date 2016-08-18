//
//  SJBTopicCell.h
//  小白
//
//  Created by zyyt on 16/7/4.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@class  SJBTopicModel;
@class SJBTopicCell;

@protocol SJBTopicCellDelegate <NSObject>

- (void)shrewith:(SJBTopicModel*)topic;

- (void)sjbTopicCell:(SJBTopicCell*)cell playVideoWithTopic:(SJBTopicModel*)topic;

@end

@interface SJBTopicCell : UITableViewCell<IFlySpeechSynthesizerDelegate>
@property (nonatomic,strong)IFlySpeechSynthesizer *iFlySpeechSynthesizer;

+ (instancetype)cell;

@property (nonatomic,strong)SJBTopicModel * model;

@property (nonatomic,weak)id<SJBTopicCellDelegate>delegate;

+ (__kindof SJBTopicCell*)tableViewRegisterCellWithTableview:(UITableView *)tableView;

@end
