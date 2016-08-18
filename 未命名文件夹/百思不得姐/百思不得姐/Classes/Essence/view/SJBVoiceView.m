//
//  SJBVoiceView.m
//  小白
//
//  Created by zyyt on 16/7/8.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBVoiceView.h"
#import "SJBTopicModel.h"
#import "UIImageView+WebCache.h"
#import "SJBPlayVoice.h"
#import "XFVociePlayerController.h"



@interface SJBVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *playtTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@property (nonatomic,strong) XFVociePlayerController *voicePlayer;

@property (nonatomic,assign)BOOL isPlay;

@end

@implementation SJBVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
  self.autoresizingMask = UIViewAutoresizingNone;

}

- (void)setTopic:(SJBTopicModel *)topic
{
    _topic = topic;
    
    if (self.isPlay == NO && self.voicePlayer) {
        [self reset];
    }
    
    if (self.isPlay == YES) {
        
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playImageView.userInteractionEnabled = YES;
    [self.playImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(paly:)]];
   
    self.playCount.text =   topic.playcount > 10000? [NSString stringWithFormat:@"%zd万播放",topic.playcount/10000]:[NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minte = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.playtTime.text = [NSString stringWithFormat:@"%02zd:%02zd",minte,second];
    
}

- (void)paly:(UITapGestureRecognizer*)tap
{
    //self.playBtn.hidden = YES;
    self.voicePlayer = [[XFVociePlayerController alloc]initWithNibName:NSStringFromClass([XFVociePlayerController class]) bundle:nil];
    self.voicePlayer.url = self.topic.voiceuri;
    self.voicePlayer.totalTime = self.topic.voicetime;
    self.voicePlayer.view.width = self.imageView.width;
    self.voicePlayer.view.y = self.imageView.height - self.voicePlayer.view.height;
    self.isPlay = YES;
    [self addSubview:self.voicePlayer.view];
    
}
//重置
-(void)reset {
    
    [self.voicePlayer dismiss];
    [self.voicePlayer.view removeFromSuperview];
    self.voicePlayer = nil;
    //self.playBtn.hidden = NO;
}

@end
