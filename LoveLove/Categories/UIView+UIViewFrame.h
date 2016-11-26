//
//  UIView+UIViewFrame.h
//  anz
//
//  Created by KevinCao on 16/6/28.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewFrame)
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic, readonly) CGFloat right;
@property(nonatomic, readonly) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
