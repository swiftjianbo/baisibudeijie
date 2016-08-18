//
//  SJBTagCell.m
//  小白
//
//  Created by zyyt on 16/6/28.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTagCell.h"
#import "SJBTagsModel.h"

@interface SJBTagCell ()
//夜间模式相关
@property (weak, nonatomic) IBOutlet UIImageView *nightModeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellBottomLine;


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describleLabel;

@end

@implementation SJBTagCell

+ (SJBTagCell*)getTableViewcellWithTableView:(UITableView*)tableview
{
    SJBTagCell * cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([tableview class])];
    if (cell == nil) {
        cell = (SJBTagCell*)[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    }
    return cell;
}

- (void)setTagModel:(SJBTagsModel *)tagModel
{
    _tagModel = tagModel;
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.nightModeImageView.image = [UIImage imageNamed:@"mainCellBackground"];
        
        self.cellBottomLine.image = [[UIImage imageNamed:@"mainCellTopN"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];

    }else{
        self.nightModeImageView.image = [UIImage imageNamed:@"mainCellBackgroundN"];
    //    self.cellBottomLine.image = [[UIImage imageNamed:@"mainCellTop"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    }
    
    
    [self class];
    
    [SJBTagCell class];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!image) {
            self.iconView.image = [[UIImage imageNamed:@"defaultUserIcon"] sjb_CircleImage];
        }else{
            self.iconView.image = [image sjb_CircleImage];

        }
        
    }];
    
    self.nameLabel.text = tagModel.theme_name;
    
    self.describleLabel.text = [NSString stringWithFormat:@"%@人订阅",tagModel.sub_number];
    
}



@end
