//
//  ComBaseViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComBaseViewController : UIViewController

@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView* contentView;

- (void)leftBtnAction;
- (void)rightBtnAction;
- (void)loadSubViews;
- (void)layoutConstraints;
- (void)loadData;
/**
 *  处理键盘弹出时遮住输入框
 */
- (void)handleKeyboardShowEvent;
- (void)handleKeyboardShowEventForScrollView:(UIScrollView *)scrollView;

@end
