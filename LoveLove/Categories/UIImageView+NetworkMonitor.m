//
//  UIImageView+NetworkMonitor.m
//  anz
//
//  Created by KevinCao on 16/7/15.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import "UIImageView+NetworkMonitor.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import <objc/runtime.h>

@interface UIImageView ()
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,retain)UIImage *placeholder;
@end

@implementation UIImageView (NetworkMonitor)

- (void)setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder
{
    self.urlString = urlString;
    self.placeholder = placeholder;
    [self setImage];
}

- (void)setImage
{
    //从内存\沙盒缓存中获得原图
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.urlString];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        [self sd_setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:self.placeholder];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:self.placeholder];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
            BOOL alwaysDownloadOriginalImage = ![[NSUserDefaults standardUserDefaults] boolForKey:kConfigManualDownloadPictures];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [self sd_setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:self.placeholder];
            } else {
                [self sd_setImageWithURL:nil placeholderImage:self.placeholder];
            }
        } else { // 没有网络
            [self sd_setImageWithURL:nil placeholderImage:self.placeholder];
        }
    }
}

-(UITapGestureRecognizer *)urlString
{
    return objc_getAssociatedObject(self,@selector(urlString));
}

-(void)setUrlString:(UITapGestureRecognizer *)value
{
    objc_setAssociatedObject(self,@selector(urlString),(id)value,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(UIImage *)placeholder
{
    return objc_getAssociatedObject(self,@selector(placeholder));
}

-(void)setPlaceholder:(UIImage *)value
{
    objc_setAssociatedObject(self,@selector(placeholder),(id)value,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
