//
//  AppDelegate.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComTabBarController.h"
#import "ComNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ComTabBarController *tabBarController;
@property (nonatomic, strong) ComNavigationController *nav;

@property (copy, nonatomic) NSArray *sidArray;

+(AppDelegate *)shareAppDelegate;

@end

