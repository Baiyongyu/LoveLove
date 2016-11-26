//
//  SXCommon.m
//  Forum
//
//  Created by SunX on 14-5-7.
//  Copyright (c) 2014年 SunX. All rights reserved.
//

#import "AppCommon.h"
#import <sys/sysctl.h>
#import <Security/Security.h>

UIWindow *mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

UIViewController *topMostViewController() {
    UIViewController *topViewController = mainWindow().rootViewController;
    UIViewController *temp = nil;
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    return topViewController;
}


@implementation AppCommon



+ (void)showNavigationBar:(BOOL)isShow {
    UINavigationController *nav = (UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController];
    nav.navigationBarHidden = !isShow;
}

+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] pushViewController:vc animated:animated];
}

+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]
     presentViewController:vc
     animated:animated
     completion:nil];
}

+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties {
    [self pushWithVCClass:NSClassFromString(className) properties:properties];
}

+ (void)pushWithVCClass:(Class)vcClass {
    [self pushWithVCClass:vcClass properties:nil];
}

+ (void)pushWithVCClassName:(NSString*)className {
    [self pushWithVCClassName:className needLogin:NO];
}

+ (void)popViewControllerAnimated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] popViewControllerAnimated:animated];
}

+ (UINavigationController *)rootNavigationController {
    return (UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController];
}

+ (void)removeVC:(UIViewController *)thevc {
    UINavigationController *nav = (UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController];
    NSMutableArray *vcs = [nav.viewControllers mutableCopy];
    [vcs removeObject:thevc];
    nav.viewControllers = [vcs copy];
}


@end

