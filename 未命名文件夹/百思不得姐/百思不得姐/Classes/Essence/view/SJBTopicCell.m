//
//  SJBTopicCell.m
//  小白
//
//  Created by zyyt on 16/7/4.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTopicCell.h"
#import "SJBTopicModel.h"
#import "SJBTopicPictureView.h"
#import "SJBVoiceView.h"
#import "SJBVideoView.h"
#import "TTSSpeak.h"




@interface SJBTopicCell ()<SJBVideoViewDelegate>
//夜间模式相关
@property (weak, nonatomic) IBOutlet UIImageView *nightModeBackImageView;


@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLable;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (nonatomic,strong)SJBTopicPictureView * pictureView;

@property (nonatomic,strong)SJBVoiceView * voiceView;

@property (nonatomic,strong)SJBVideoView * videoView;


@end

static NSString * const ID = @"Topic";

@implementation SJBTopicCell

- (IFlySpeechSynthesizer *)iFlySpeechSynthesizer
{
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        _iFlySpeechSynthesizer.delegate =
        self;
        //2.设置合成参数
        //设置在线工作方式
        [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
        //音量,取值范围 0~100
        [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
        [_iFlySpeechSynthesizer setParameter:@"30" forKey: [IFlySpeechConstant SPEED]];
        
        [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
[_iFlySpeechSynthesizer setParameter:@"xiaokun" forKey:[IFlySpeechConstant VOICE_NAME]];
        [_iFlySpeechSynthesizer setParameter:@"0" forKey:[IFlySpeechConstant VOICE_LANG]];

    }
    return _iFlySpeechSynthesizer;
}

/*
  *Prepares a reusable cell for reuse by the table view's delegate.
  *If a UITableViewCell object is reusable—that is, it has a reuse *identifier—this method is invoked just before the object is *returned from the UITableView method *dequeueReusableCellWithIdentifier:. For performance *reasons, you should only reset attributes of the cell that are *not related to content, for example, alpha, editing, and *selection state. The table view's delegate in *tableView:cellForRowAtIndexPath: should always reset all content when reusing a cell. If the cell object does not have an associated reuse identifier, this method is not called. If you override this method, you must be sure to invoke the superclass implementation.
 */
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [_voiceView reset];
    [_videoView reset];
}

+ (instancetype)cell
{
    SJBTopicCell * cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

    return cell;
}

//懒加载
- (SJBTopicPictureView *)pictureView
{
    if (!_pictureView) {
        SJBTopicPictureView *pictureView = [SJBTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (SJBVoiceView *)voiceView
{
    if (!_voiceView) {
        SJBVoiceView *voiceView = [SJBVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (SJBVideoView *)videoView
{
    if (!_videoView) {
       SJBVideoView *  videoView = [SJBVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

//
+ (SJBTopicCell *)tableViewRegisterCellWithTableview:(UITableView *)tableView
{
      [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:ID];
    SJBTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

//为cell赋值
- (void)setModel:(SJBTopicModel *)model
{
         _model = model;
    
      
       [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           self.profile_imageView.image =  image? [image sjb_CircleImage]:[[UIImage imageNamed:@"defaultUserIcon"] sjb_CircleImage];
           
       }];
    
         self.nameLabel.text = model.name;
    self.nameLabel.textColor = [UIColor redColor];
   

   
          self.creatTimeLable.text = model.created_at;
     self.creatTimeLable.textColor = [NightModeShareInstance shareInstance].commonTextColor;

   

        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",model.love] forState:UIControlStateNormal];


        [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",model.hate] forState:UIControlStateNormal];

        [self.shareButton setTitle:[NSString stringWithFormat:@"%zd",model.repost] forState:UIControlStateNormal];

   
        [self.commentButton  setTitle:[NSString stringWithFormat:@"%zd",model.comment] forState:UIControlStateNormal];
 

    if (model.type == SJBTopicTypePicture) {
        self.pictureView.topic = model;
        self.pictureView.frame = model.pictureF;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        [self.contentView addSubview:self.pictureView];
    }else if (model.type == SJBTopicTypeVoice){
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.topic = model;
       self.voiceView.frame = model.voiceF;
        
        [self.contentView addSubview:self.voiceView];
  
    }else if(model.type == SJBTopicTypeVideo){
        self.videoView.topic = model;
        self.videoView.frame = model.videoF;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.videoDelegate = self;
        
        [self.contentView addSubview:self.videoView];
    }else{
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }

  
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.nightModeBackImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    }else{
        self.nightModeBackImageView.image = [UIImage imageNamed:@"mainCellBackgroundN"];
     }
    
    self.text_label.text = model.text;
    self.text_label.textColor = [NightModeShareInstance shareInstance].commonTextColor;
    
}


- (void)awakeFromNib {
    
    [self.shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
}

//分享
- (void)share:(UIButton*)btn
{
    if ([self.delegate  respondsToSelector:@selector(shrewith:)]) {
        [self.delegate shrewith:self.model];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//播放视频
- (void)playWithTopic:(SJBTopicModel *)topic
{
    if ([self.delegate respondsToSelector:@selector(sjbTopicCell:playVideoWithTopic:)]) {
        [self.delegate sjbTopicCell:self playVideoWithTopic:topic];
    }
}


//tts如果是段子我们可以读出来
- (IBAction)voiceClick:(id)sender {

    if (self.model.type == SJBTopicTypeWord) {
        
//        [[TTSSpeak shareInstance] stopSpeaking];
//        
//        [[TTSSpeak shareInstance] playText:self.model.text withNativeLanguage:@"zh-CN" rate:@"0.9" volume:@"0.5"];
        
        [self.iFlySpeechSynthesizer stopSpeaking];
        [self.iFlySpeechSynthesizer startSpeaking:self.model.text];
    }
    
    
}

@end
