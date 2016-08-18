//
//  SJBBarButtonItem.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBBarButtonItem : UIBarButtonItem

+ (instancetype)creatBarButtonItemWithImage:(NSString*)imageName selectImage:(NSString*)selectImageName  target:(id)target action:(SEL)selector;

+ (instancetype)creatBarButtonItemWithTitleName:(NSString*)title  target:(id)target action:(SEL)selector;

@end
