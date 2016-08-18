//
//  SJBVideoView.m
//  小白
//
//  Created by zyyt on 16/7/8.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBVideoView.h"
#import "UIImageView+WebCache.h"
#import "SJBTopicModel.h"
#import "KRVideoPlayerController.h"

@interface SJBVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playCount;

@property (weak, nonatomic) IBOutlet UILabel *playTime;

@property (weak, nonatomic) IBOutlet UIImageView *videoView;

@property (strong, nonatomic) KRVideoPlayerController *videoController;

@end

@implementation SJBVideoView

+ (instancetype)videoView
{
 return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
   
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setTopic:(SJBTopicModel *)topic
{
    _topic = topic;
    
   
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCount.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minte = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.playTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minte,second];

    
    
}

- (IBAction)playVideo:(id)sender {
 
    
    [self playVideoWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self addSubview:self.videoController.view];
    
}

- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:self.videoView.bounds];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
    }
    self.videoController.contentURL = url;
}

//停止视频的播放
- (void)reset {
   [self.videoController dismiss];
    self.videoController = nil;
    }





@end
