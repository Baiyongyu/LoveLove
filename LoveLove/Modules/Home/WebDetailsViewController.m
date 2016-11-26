//
//  WebDetailsViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "WebDetailsViewController.h"

@interface WebDetailsViewController () <UIGestureRecognizerDelegate>

@end

@implementation WebDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILongPressGestureRecognizer * longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    
    longPressed.minimumPressDuration = 0.3;
    longPressed.numberOfTouchesRequired = 1;
        longPressed.delegate = self;
    [self.contentWebView addGestureRecognizer:longPressed];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)longPressed:(UITapGestureRecognizer*)recognizer {
    
    //只在长按手势开始的时候才去获取图片的url
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.contentWebView];
    
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.contentWebView stringByEvaluatingJavaScriptFromString:js];
    
    if (urlToSave.length == 0) {
        return;
    }
    NSLog(@"获取到图片地址：%@",urlToSave);
    
    [UIAlertController showAlertInViewController:self withTitle:@"温馨提示" message:@"是否要保存图片?" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == controller.destructiveButtonIndex) {
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlToSave]];
            UIImage *image = [UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);            
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error == nil) {
        [MBProgressHUD showTip:@"保存成功"];
    }else{
        [MBProgressHUD showTip:@"保存失败"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
