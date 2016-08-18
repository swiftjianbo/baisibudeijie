//
//  SJBMyWebViewController.h
//  小白
//
//  Created by zyyt on 16/7/18.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"

@interface SJBMyWebViewController : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic,copy)NSString * urlStr;

@end
