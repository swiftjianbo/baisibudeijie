//
//  SJBShowImageViewController.m
//  小白
//
//  Created by zyyt on 16/7/5.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBShowImageViewController.h"
#import "SJBTopicModel.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocialControllerService.h"
#import "UMSocial.h"

@interface SJBShowImageViewController ()<UMSocialUIDelegate>
@property (nonatomic,strong)UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SJBShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView = [[UIImageView alloc] init];
  imageView.userInteractionEnabled = NO;
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
//    [self.imageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(back: )]];
    
    CGFloat pictureW = screenW;
    CGFloat pictureH =   pictureW * self.topic.height / self.topic.width;

    if (pictureH > screenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    //[self.view   insertSubview:self.imageView atIndex:1];
    
 [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    
}


- (IBAction)back:(id)sender {
    
    [SVProgressHUD dismiss];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)share:(id)sender {
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@",self.topic.weixin_url]];
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@",self.topic.name];
    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@",self.topic.weixin_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMSocialKey
                                      shareText:[NSString stringWithFormat:@"%@",self.topic.text]
                                     shareImage:self.imageView.image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                       delegate:self];
}

- (IBAction)save:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)saveIMage:(id)longPress
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}




@end
