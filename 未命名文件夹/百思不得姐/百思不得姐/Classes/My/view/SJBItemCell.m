//
//  SJBItemCell.m
//  小白
//
//  Created by zyyt on 16/7/18.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBItemCell.h"
#import "SJBMyModel.h"

@interface SJBItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SJBItemCell

- (void)awakeFromNib {

    self.autoresizingMask = UIViewAutoresizingNone;

}

- (void)setMyModel:(SJBMyModel *)myModel
{
    _myModel = myModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:myModel.icon]];
    
    
    
    
    self.nameLabel.text = myModel.name;
    self.nameLabel.textColor = [NightModeShareInstance shareInstance].commonTextColor;
    
}

@end
