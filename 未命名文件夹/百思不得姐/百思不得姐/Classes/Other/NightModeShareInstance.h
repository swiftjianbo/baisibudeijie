//
//  NightModeShareInstance.h
//  夜间模式2
//
//  Created by zyyt on 16/7/27.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    
    NightModeDay,
    NightModeNight
    
}NightMode;

@interface NightModeShareInstance : NSObject

//模式
@property (nonatomic,assign)NightMode mode;

@property (nonatomic,readonly)UIColor * commonTextColor;

@property (nonatomic,readonly)UIColor * commonBgColor;

@property (nonatomic,readonly)UIImage * commonTabBarImage;



//单例
+ (instancetype)shareInstance;

- (UIColor*)commonTextColor;

- (UIColor*)commonBgColor;

- (UIImage*)commonTabBarImage;




@end
