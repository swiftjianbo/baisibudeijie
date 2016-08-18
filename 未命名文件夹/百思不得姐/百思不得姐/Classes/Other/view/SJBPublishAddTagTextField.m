//
//  SJBPublishAddTagTextField.m
//  小白
//
//  Created by zyyt on 16/7/19.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBPublishAddTagTextField.h"

@implementation SJBPublishAddTagTextField

- (void)deleteBackward
{
    
    !self.publishAddTagTextFieldBlock ? : self.publishAddTagTextFieldBlock(self.text.length);
    
    [super deleteBackward];
}

@end
