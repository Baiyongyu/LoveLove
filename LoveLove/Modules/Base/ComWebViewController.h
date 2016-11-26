//
//  BaseWebViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComBaseViewController.h"

@interface ComWebViewController : ComBaseViewController <UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *contentWebView;
//网页链接
@property(nonatomic,copy)NSString *urlStr;
//本地文件路径
@property(nonatomic,copy)NSString *filePath;
//html内容
@property(nonatomic,copy)NSString *content;
@end
