//
//  BaseWebViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComWebViewController.h"

@interface ComWebViewController ()

@end

@implementation ComWebViewController

- (void)loadSubViews
{
    [super loadSubViews];
    self.leftBtn.hidden = NO;
    [self.view addSubview:self.contentWebView];
}

- (void)layoutConstraints
{
    WS(weakSelf);
    [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void)loadData
{
    if (self.urlStr.length) {
        NSURL* url=[NSURL URLWithString:self.urlStr relativeToURL:[NSURL URLWithString:@"http://"]];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [self.contentWebView loadRequest:request];
        return;
    }
    if (self.filePath.length) {
        NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:self.filePath ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:bundleFilePath encoding:NSUTF8StringEncoding error:nil];
        [self.contentWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:bundleFilePath]];
        return;
    }
    if (self.content.length) {
        [self.contentWebView loadHTMLString:self.content baseURL:nil];
        return;
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!self.titleLabel.text.length) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.titleLabel.text = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - getters and setters
- (UIWebView *)contentWebView
{
    if (!_contentWebView) {
        _contentWebView=[[UIWebView alloc] init];
        _contentWebView.scalesPageToFit =YES;
        _contentWebView.delegate =(id)self;
        [_contentWebView setBackgroundColor:[UIColor clearColor]];
        [_contentWebView setOpaque:NO];
    }
    return _contentWebView;
}

@end
