//
//  SJBTagCell.h
//  小白
//
//  Created by zyyt on 16/6/28.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJBTagsModel;
@interface SJBTagCell : UITableViewCell
+ (SJBTagCell*)getTableViewcellWithTableView:(UITableView*)tableview;
@property (nonatomic,strong)SJBTagsModel * tagModel;
@end
