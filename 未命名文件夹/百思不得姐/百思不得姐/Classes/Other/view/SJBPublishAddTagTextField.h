//
//  SJBPublishAddTagTextField.h
//  小白
//
//  Created by zyyt on 16/7/19.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBPublishAddTagTextField : UITextField
@property (nonatomic,copy)void (^publishAddTagTextFieldBlock)(NSInteger length);
@end
