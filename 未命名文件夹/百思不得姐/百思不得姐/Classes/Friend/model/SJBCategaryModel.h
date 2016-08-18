//
//  SJBCategaryModel.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJBCategaryModel : NSObject

@property (nonatomic,assign)NSInteger id;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSMutableArray * userArrM;

@property (nonatomic,assign)NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;


@end
