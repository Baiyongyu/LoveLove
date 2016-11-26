//
//  SXCommon.h
//  Forum
//
//  Created by SunX on 14-5-7.
//  Copyright (c) 2014年 SunX. All rights reserved.
//
#import <UIKit/UIKit.h>

UIWindow *mainWindow();

UIViewController *topMostViewController();

typedef enum {
    TDDManagerEnvironmentDaily,
    TDDManagerEnvironmentPreRelease,
    TDDManagerEnvironmentRelease
} TDDManagerEnvironment;

@interface AppCommon : NSObject

////隐藏导航栏
+ (void)showNavigationBar:(BOOL)isShow;

////统一调用此方法来push
+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animate;
+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated;
+ (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties;
+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties;
+ (void)pushWithVCClass:(Class)vcClass;
+ (void)pushWithVCClassName:(NSString*)className;
+ (void)pushWithVCClassName:(NSString*)className needLogin:(BOOL)isNeedLogin;
+ (void)popViewControllerAnimated:(BOOL)animated;
+ (UINavigationController *)rootNavigationController;
+ (void)removeVC:(UIViewController *)thevc;

@end





