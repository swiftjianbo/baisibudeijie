//
//  SJBConment.m
//  小白
//
//  Created by zyyt on 16/7/11.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBConment.h"

@implementation SJBConment

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"user"]) {
        SJBLog(@"%@",value);
        
        SJBUser * user = [[SJBUser alloc] init];
        [user setValuesForKeysWithDictionary:value];
         self.uSer = user;
    }
}


- (CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        CGFloat top = 55;
        
        CGFloat textHeight = [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = top + textHeight + 15
        ;
        
    }
    
    return _cellHeight;
}



@end
