//
//  SJBTopicPictureView.m
//  小白
//
//  Created by zyyt on 16/7/5.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTopicPictureView.h"
#import "SJBTopicModel.h"
#import "SJBLabeledCircularProgressView.h"
#import "SJBShowImageViewController.h"

@interface SJBTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageButton;
@property (weak, nonatomic) IBOutlet SJBLabeledCircularProgressView *progressView;

@end

@implementation SJBTopicPictureView


+ (__kindof SJBTopicPictureView*)pictureView{
    
    SJBTopicPictureView * topic = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    
    return topic;
    
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)]];
    
}

- (void)showImage:(UITapGestureRecognizer*)tap
{
    SJBShowImageViewController * showImage = [[SJBShowImageViewController alloc] init];
    showImage.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showImage animated:YES completion:nil];
}



- (void)setTopic:(SJBTopicModel *)topic
{
    _topic = topic;

    
 
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    if (self.topic.pictureProgress >= 100) {
          self.progressView.hidden = YES;
    }else{
        self.progressView.hidden = NO;
        [self.progressView  setProgress:topic.pictureProgress  animated:NO];
 
    }
    
    
    

    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = (receivedSize == expectedSize);
        
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;

        [self.progressView setProgress:topic.pictureProgress  animated:NO];
   } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
       self.progressView.hidden = YES;
       
       // 如果是大图片, 才需要进行绘图处理
       if (topic.isBigPicture == NO) return;
       
       // 开启图形上下文
       UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
       
       // 将下载完的image对象绘制到图形上下文
       CGFloat width = topic.pictureF.size.width;
       CGFloat height = width * image.size.height / image.size.width;
       [image drawInRect:CGRectMake(0, 0, width, height)];
       
       // 获得图片
       self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
       
       // 结束图形上下文
       UIGraphicsEndImageContext();
   }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
//    if (topic.isBigPicture) { // 大图
//        self.seeBigButton.hidden = NO;
//    } else { // 非大图
//        self.seeBigButton.hidden = YES;
//    }
//
//    }];

    NSString * gif = topic.large_image.pathExtension;
    
    if ([[gif  lowercaseString] isEqualToString:@"gif"]) {
        self.gifView.hidden = NO;

    }else{
        self.gifView.hidden = YES;
    }
   
  if (topic.isBigPicture) { // 大图
         self.seeBigImageButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigImageButton.hidden = YES;
        
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    
}

@end
