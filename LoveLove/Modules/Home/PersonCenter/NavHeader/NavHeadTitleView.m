//
//  NavHeadTitleView.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "NavHeadTitleView.h"

@interface NavHeadTitleView()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *back;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@end

@implementation NavHeadTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.headBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor = [UIColor whiteColor];
//        self.headBgView.image = [UIImage imageNamed:@"nav－-bar"];
        // 隐藏黑线
        self.headBgView.alpha = 0;
        [self addSubview:self.headBgView];
        

        self.backgroundColor = [UIColor clearColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.label];
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.backgroundColor = [UIColor clearColor];
        self.leftBtn.frame = CGRectMake(15, 25, 30, 30);
        [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBtn];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-46, 30, 30, 30);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)setLeftImageView:(NSString *)leftImageView {
    _leftImageView = leftImageView;
    [self.leftBtn setImage:[UIImage imageNamed:_leftImageView] forState:UIControlStateNormal];
}
- (void)setLeftTitleImage:(NSString *)leftImageView {
    _leftImageView = leftImageView;
    [self.leftBtn setImage:[UIImage imageNamed:_leftImageView] forState:UIControlStateNormal];
}

- (void)setRightImageView:(NSString *)rightImageView {
    _rightImageView = rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}
- (void)setRightTitleImage:(NSString *)rightImageView {
    _rightImageView = rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    self.label.textColor = color;
}


- (void)leftBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToLeft)]) {
        [_delegate NavHeadToLeft];
    }
}

- (void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight)]) {
        [_delegate NavHeadToRight];
    }
}
- (void)jianBian {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.label.frame;
    gradientLayer.colors = @[(id)[UIColor colorWithRed:222/225.0 green:98/255.0 blue:26/255.0 alpha:0.1].CGColor, (id)[UIColor colorWithRed:245/225.0 green:163/255.0 blue:17/255.0 alpha:1].CGColor];
    gradientLayer.mask = self.label.layer;
    [self.layer addSublayer:gradientLayer];
    self.label.frame = gradientLayer.bounds;
}

@end
