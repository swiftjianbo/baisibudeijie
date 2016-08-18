//
//  XFVociePlayerController.h
//  小白
//
//  Created by zyyt on 16/7/14.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface XFVociePlayerController : UIViewController

@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
-(void)dismiss;

@end
