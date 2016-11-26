//
//  ToViewTopButton.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TOTOPBUTTON_WH 45
#define EDGE_MARGIN 18


@interface ToViewTopButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;
/**
 *  设置滚动视图偏移量为多少时显示按钮,如果不设置默认为zero点
 */
@property (nonatomic ,assign) CGFloat showBtnOffset;

/**
 *  设置滚动视图滚动的偏移量坐标,如果不设置默认为zero(滚动到顶部)
 */
@property (nonatomic ,assign) CGPoint scrollToPoint;

/**
 *  设置按钮控制scrollerView视图的滚动方法
 *
 *  @param scrollView   被控制的滚动视图对象
 *  @param touchHandler 点击按钮的block回调
 */
- (void)scrollView:(UIScrollView *__unsafe_unretained)scrollView clickButtonActionHandler:(void(^)(UIButton *btn))touchHandler;

@end
