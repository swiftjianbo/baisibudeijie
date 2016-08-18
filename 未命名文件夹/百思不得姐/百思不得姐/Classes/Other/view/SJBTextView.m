
//
//  SJBTextView.m
//  小白
//
//  Created by zyyt on 16/7/15.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTextView.h"


@interface SJBTextView()
@property (nonatomic,strong)UILabel * placeHoldLabel;
@end

@implementation SJBTextView

- (UILabel *)placeHoldLabel
{
    if (_placeHoldLabel == nil) {
        _placeHoldLabel = [[UILabel alloc] init];
        _placeHoldLabel.textColor = [UIColor grayColor];
        _placeHoldLabel.textAlignment = NSTextAlignmentLeft;
        _placeHoldLabel.numberOfLines = 0;
        _placeHoldLabel.userInteractionEnabled = YES;
        [self addSubview:self.placeHoldLabel];

    }
    return _placeHoldLabel;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.showsVerticalScrollIndicator = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHoldLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [self.placeHoldLabel sizeThatFits:CGSizeMake(self.width -6, MAXFLOAT)];
    self.placeHoldLabel.frame =CGRectMake(3, 7,self.width -6 , size.height);
    
}

- (void)textChanged:(NSNotification*)noti{

    if (self.hasText) {
        self.placeHoldLabel.hidden = YES;
    }else{
        self.placeHoldLabel.hidden = NO;
    }
    
}

- (void)setPlacehold:(NSString *)placehold
{
    _placehold = placehold;
    self.placeHoldLabel.text = placehold;
    [self layoutSubviews];
}

- (void)setPlaceholdTextColor:(UIColor *)placeholdTextColor
{
    _placeholdTextColor = placeholdTextColor;
    self.placeHoldLabel.textColor = placeholdTextColor;
    [self layoutSubviews];

}


- (void)setPlaceholdTextFont:(NSInteger)placeholdTextFont
{
    _placeholdTextFont = placeholdTextFont;
    self.placeHoldLabel.font = [UIFont systemFontOfSize:placeholdTextFont];
    [self layoutSubviews];

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
