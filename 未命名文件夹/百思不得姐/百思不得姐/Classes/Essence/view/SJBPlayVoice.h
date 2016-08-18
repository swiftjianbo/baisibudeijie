//
//  SJBPlayVoice.h
//  小白
//
//  Created by zyyt on 16/7/12.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBPlayVoice : NSObject

+ (__kindof  SJBPlayVoice*)playVoice;


- (void)playWithURLStr:(NSString*)urlString;

@end
