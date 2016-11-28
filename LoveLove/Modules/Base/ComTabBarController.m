//
//  ComTabBarController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComTabBarController.h"
#import "HomeViewController.h"
#import "LinkPageViewController.h"
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
        
        LinkPageViewController *linkVC = [[LinkPageViewController alloc] init];
        linkVC.tabBarItem.title = @"联动";
        linkVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        linkVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_chat_32x19_"];
        
        // 中心
        CenterViewController *centerVC = [[CenterViewController alloc] init];
        centerVC.tabBarItem.title = @"中心";
        centerVC.tabBarItem.image = [UIImage imageNamed:@"ln_tab_index_22x19_"];
        centerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ln_tab_index_22x19_"];

        self.tabBar.tintColor = kNavColor;
        self.viewControllers = @[homeVC, linkVC, centerVC];
    }
    return self;
}

@end
