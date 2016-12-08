//
//  UIViewController+NavigationHandler.m
//  anz
//
//  Created by KevinCao on 16/7/12.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import "UIViewController+NavigationHandler.h"

@implementation UIViewController (NavigationHandler)

-(void)removeFormerViewControllerOfClass:(Class)ViewControllerClass
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    NSInteger selfIndex = [viewControllers indexOfObject:self];
    if (selfIndex>1 && ([viewControllers[selfIndex-1] isKindOfClass:ViewControllerClass])) {
        [viewControllers[selfIndex-1] removeFromParentViewController];
    }
}

-(void)removeFormerViewControllerOfClasses:(NSArray *)ViewControllerClassArray
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    NSInteger selfIndex = [viewControllers indexOfObject:self];
    if (selfIndex>1 && ([ViewControllerClassArray containsObject:[viewControllers[selfIndex-1] class]])) {
        [viewControllers[selfIndex-1] removeFromParentViewController];
    }
}

@end
