//
//  SJBConst.h
//  小白
//
//  Created by zyyt on 16/7/4.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>


 typedef enum {
    
     SJBTopicTypeAll = 1,
    
     SJBTopicTypeVideo = 41,
    
     SJBTopicTypePicture = 10,
    
     SJBTopicTypeVoice = 31,
    
     SJBTopicTypeWord = 29
     
  } SJBTopicType;



//topiccell中的button高度
UIKIT_EXTERN CGFloat  const  SJBTopicCellTextBottom;

UIKIT_EXTERN CGFloat const SJBPublishToolViewHeight;

//添加标签里面的textField的高度
UIKIT_EXTERN  CGFloat const SJBPublishAddTagMarginHeight;

/** JPush -------> */
 UIKIT_EXTERN  NSString *const channel ;
 UIKIT_EXTERN  NSString * const JPushKey;
 UIKIT_EXTERN  BOOL const isProduction ;

/**<------- JPush */

/** UMShare  ------->*/

UIKIT_EXTERN NSString * const  UMSocialKey;


/**微信  ------->*/
UIKIT_EXTERN NSString * const WXAppID ;
UIKIT_EXTERN  NSString * const WXSecret ;

/**QQ  ------->*/
UIKIT_EXTERN NSString * const QQAppID ;
 UIKIT_EXTERN NSString * const QQAppKey ;

/**Sina   ------->*/
 UIKIT_EXTERN NSString * const SinaAppKey;
 UIKIT_EXTERN NSString * const SinaSecret ;

/** <-------  UMShare*/





