//
//  MBProgressHUD+ANZ.m
//  anz
//
//  Created by KevinCao on 16/7/4.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import "MBProgressHUD+QM.h"
#import <objc/runtime.h>

@interface MBProgressHUD ()
@property(nonatomic,copy)NSNumber *hudCount;
@end

@implementation MBProgressHUD (QM)

-(NSNumber *)hudCount
{
    return objc_getAssociatedObject(self,@selector(hudCount));
}

-(void)setHudCount:(NSNumber *)hudCount
{
    objc_setAssociatedObject(self,@selector(object),(id)hudCount,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (MB_INSTANCETYPE)showHUDOnView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *hud = [self HUDForView:view];
    if (!hud) {
        return [self showHUDAddedTo:view animated:animated];
    }
    hud.hudCount = @(hud.hudCount.integerValue+1);
    return hud;
}

+ (BOOL)hideHUDOnView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        if (!hud.hudCount.integerValue) {
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:animated];
            return YES;
        }
        hud.hudCount = @(hud.hudCount.integerValue-1);
    }
    return NO;
}

+ (MBProgressHUD *)showTip:(NSString *)tip
{
    if (!tip.length) {
        return nil;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hud.detailsLabelText = tip;
    hud.detailsLabelFont = XiHeiFont(16);
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    CGFloat hiddenTime = 1.0;
    if (tip.length>15) {
        hiddenTime = 1.5;
    }
    [hud hide:YES afterDelay:hiddenTime];
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

@end
