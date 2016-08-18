//
//  SJBTopicModel.m
//  小白
//
//  Created by zyyt on 16/7/4.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTopicModel.h"

@interface SJBTopicModel ()
{
    CGFloat _cellHeight;
}
@end

@implementation SJBTopicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
 
    if ([key isEqualToString:@"top_cmt"]) {
        self.top_cmt =  value[0];
    }
    if ([key isEqualToString:@"id"]) {
        self.ID =  value;
    }

    
    if ([key isEqualToString:@"image0"]) {
        self.small_image = (NSString*)value;
    }

    if ([key isEqualToString:@"image1"]) {
        self.large_image = (NSString*)value;
    }
   
    if ([key isEqualToString:@"image2"]) {
        self.middle_image = (NSString*)value;
    }

}

- (CGFloat)cellHeight
{
        
    if (_cellHeight == 0) {
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * 10, MAXFLOAT);
        
        CGFloat textY = 55;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = textY + textH ;
        
        if (self.type == SJBTopicTypePicture) {
            
            // 图片显示出来的宽度
            CGFloat pictureW = [UIScreen mainScreen].bounds.size.width - 2* 10;
            // 显示显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= 1000) { // 图片高度过长
                pictureH = 250;
                self.bigPicture = YES; // 大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = 10;
            CGFloat pictureY = textY + textH + 10;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        
            _cellHeight += pictureH + 10;
        }else if (self.type == SJBTopicTypeVoice){
            // 图片显示出来的宽度
            CGFloat pictureW =  [UIScreen mainScreen].bounds.size.width - 2* 10;
            
            //SJBLog(@"pictureW %f",pictureW);
            
             CGFloat pictureH = pictureW * self.height / self.width;
            CGFloat pictureX = 10;
            CGFloat pictureY = _cellHeight + 10;
            _voiceF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
           
            _cellHeight += _voiceF.size.height + 10;
            
        }else if (self.type == SJBTopicTypeVideo){
            // 图片显示出来的宽度
            CGFloat pictureW =   [UIScreen mainScreen].bounds.size.width - 2* 10;
        
            
            CGFloat pictureH = pictureW * self.height / self.width;
            CGFloat pictureX = 10;
            CGFloat pictureY = _cellHeight + 10;
            _videoF = CGRectMake(pictureX, pictureY, pictureW, pictureH);

            
            _cellHeight += _videoF.size.height + 10;
            
        }

        


     _cellHeight  += SJBTopicCellTextBottom  ;
        
    }
   
    
    return _cellHeight;
}

@end
