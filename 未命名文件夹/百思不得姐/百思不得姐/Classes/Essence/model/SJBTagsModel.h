//
//  SJBTagsModel.h
//  小白
//
//  Created by zyyt on 16/6/28.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBTagsModel : NSObject
/*注释*/
@property (nonatomic,strong)NSString * theme_id;
/*注释*/
@property (nonatomic,strong)NSString * theme_name;
/*注释*/
@property (nonatomic,strong)NSString * image_list;
@property (nonatomic,strong)NSString * sub_number;
@property (nonatomic,assign)NSInteger * is_sub;
@property (nonatomic,assign)NSInteger * is_default;



@end
