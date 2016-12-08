//
//  UIViewController+NavigationHandler.h
//  anz
//
//  Created by KevinCao on 16/7/12.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationHandler)
/**
 *  从页面栈中移除上一级页面
 *
 *  @param ViewControllerClass 上级页面类
 */
-(void)removeFormerViewControllerOfClass:(Class)ViewControllerClass;

/**
 *  从页面栈中移除上一级页面
 *
 *  @param ViewControllerClassArray 上级页面类数组
 */
-(void)removeFormerViewControllerOfClasses:(NSArray *)ViewControllerClassArray;

@end
