//
//  NavHeadTitleView.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavHeadTitleViewDelegate <NSObject>

@optional
- (void)NavHeadToLeft;
- (void)NavHeadToRight;
@end

@interface NavHeadTitleView : UIView
@property(nonatomic,assign) id<NavHeadTitleViewDelegate>delegate;
@property(nonatomic,strong) UIImageView *headBgView;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIColor *color;

@property(nonatomic,strong) NSString *leftImageView;
@property(nonatomic,strong) NSString *leftTitleImage;
@property(nonatomic,strong) NSString *rightImageView;
@property(nonatomic,strong) NSString *rightTitleImage;
@end
