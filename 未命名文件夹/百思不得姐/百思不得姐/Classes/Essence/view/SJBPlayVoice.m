//
//  SJBPlayVoice.m
//  小白
//
//  Created by zyyt on 16/7/12.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBPlayVoice.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SJBPlayVoice ()
@property (nonatomic,strong)AVAudioPlayer * player;
@end

static SJBPlayVoice * playVoice;

@implementation SJBPlayVoice


+ (SJBPlayVoice *)playVoice
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playVoice = [[SJBPlayVoice alloc] init];
    });
    
    return playVoice;
}

- (void)playWithURLStr:(NSString *)urlString{
    

    
    
}



@end
