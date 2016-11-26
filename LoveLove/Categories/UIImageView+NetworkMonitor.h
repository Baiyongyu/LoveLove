//
//  UIImageView+NetworkMonitor.h
//  anz
//
//  Created by KevinCao on 16/7/15.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NetworkMonitor)

- (void)setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder;

@end

