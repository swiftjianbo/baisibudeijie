//
//  SJBAddTagViewController.h
//  小白
//
//  Created by zyyt on 16/7/18.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBAddTagViewController : UIViewController

@property (nonatomic,copy)void(^titleBlock )(NSArray*titlesArr);

@property (nonatomic,strong)NSArray  * titles;

@end
