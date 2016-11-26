//
//  MBProgressHUD+ANZ.h
//  anz
//
//  Created by KevinCao on 16/7/4.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (QM)

+ (MB_INSTANCETYPE)showHUDOnView:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideHUDOnView:(UIView *)view animated:(BOOL)animated;

/**
 *  显示提示(1s后自动消失)
 *
 *  @param tip 提示信息
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showTip:(NSString *)tip;

/**
 *  显示信息
 *
 *  @param message 信息
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  显示信息
 *
 *  @param message 信息
 *  @param view    显示的view
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

@end
