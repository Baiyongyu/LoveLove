//
//  ComTabBarController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComTabBarController.h"
#import "HomeViewController.h"
#import "LoveLoveViewController.h"
#import "HotViewController.h"
#import "NewViewController.h"
#import "CenterViewController.h"

@interface ComTabBarController ()

@end

@implementation ComTabBarController

- (instancetype)init {
    
    if (self = [super init]) {
        // 首页
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.tabBarItem.title = @"首页";
        homeVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_timeline_25x19_"];
        homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_timeline_25x19_"];
        
        // 爱爱
        LoveLoveViewController *loveVC = [[LoveLoveViewController alloc] initWithViewControllerClasses:@[[HotViewController class], [NewViewController class]] andTheirTitles:@[@"热门", @"最新"]];
        loveVC.tabBarItem.title = @"爱爱";
        loveVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        loveVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        
        loveVC.menuViewStyle = WMMenuViewStyleLine;
        loveVC.menuItemWidth = 80;
        loveVC.menuBGColor= [UIColor whiteColor];
        loveVC.menuHeight = 40;
        loveVC.titleColorSelected = kNavColor;
        loveVC.titleSizeNormal = 14;
        loveVC.titleSizeSelected = 14;
        
        // 中心
        CenterViewController *centerVC = [[CenterViewController alloc] init];
        centerVC.tabBarItem.title = @"中心";
        centerVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_index_22x19_"];
        centerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_index_22x19_"];

        self.tabBar.tintColor = kNavColor;
        self.viewControllers = @[homeVC, loveVC, centerVC];
    }
    return self;
}

@end
