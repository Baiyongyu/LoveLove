//
//  ComTabBarController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComTabBarController.h"
#import "HomeViewController.h"
#import "WaterLayoutViewController.h"
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
        
        WaterLayoutViewController *waterVC = [[WaterLayoutViewController alloc] init];
        waterVC.tabBarItem.title = @"嗯哼";
        waterVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        waterVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        
        // 中心
        CenterViewController *centerVC = [[CenterViewController alloc] init];
        centerVC.tabBarItem.title = @"中心";
        centerVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_index_22x19_"];
        centerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_index_22x19_"];

        self.tabBar.tintColor = kNavColor;
        self.viewControllers = @[homeVC, centerVC];
    }
    return self;
}

@end
