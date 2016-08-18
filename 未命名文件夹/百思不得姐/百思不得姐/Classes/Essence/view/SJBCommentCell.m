//
//  SJBCommentCell.m
//  小白
//
//  Created by zyyt on 16/7/14.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBCommentCell.h"
#import "SJBConment.h"
#import "SJBUser.h"

@interface SJBCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation SJBCommentCell

- (void)awakeFromNib {
  
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setComment:(SJBConment *)comment
{
    _comment = comment;
    
    self.dingCountLabel.text = comment.like_count > 10000? [NSString stringWithFormat:@"%zd万",comment.like_count/10000 ]: [NSString stringWithFormat:@"%zd",comment.like_count];
    
    self.nameLabel.text = comment.uSer.username;
    
    if ([comment.uSer.sex isEqualToString:@"m"]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:comment.uSer.profile_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profile_image.image =   image? [image sjb_CircleImage]:[[UIImage imageNamed:@"defaultUserIcon"] sjb_CircleImage];
    }];
    
    self.contentLabel.text = comment.content;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
