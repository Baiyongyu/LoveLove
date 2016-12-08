//
//  TouchWindow.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "TouchWindow.h"
#import <LocalAuthentication/LAContext.h>
#import "ViewController.h"

@interface TouchWindow ()

@property (nonatomic, strong) UIAlertAction *confirmAction;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) LAContext *context;

@end

@implementation TouchWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.windowLevel = UIWindowLevelAlert;
        self.rootViewController = [ViewController new];
    }
    
    return self;
}

- (void)show
{
    [self makeKeyAndVisible];
    self.hidden = NO;
    [self alertEvaluatePolicyWithTouchID];
}

- (void)dismiss
{
    [self resignKeyWindow];
    self.hidden = YES;
}

//successed,show animation
- (void)imageViewShowAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.rootViewController.view.alpha = 0;
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
            
        } completion:^(BOOL finished) {
            [self.rootViewController.view removeFromSuperview];
            [self dismiss];
        }];
    });
}

- (void)alertEvaluatePolicyWithTouchID
{
    [_alert dismissViewControllerAnimated:YES completion:nil];
    self.rootViewController = [ViewController new];
    _context = [LAContext new];
    NSError *error;
    //Whether the device support touch ID? ---if it's yes,support!Otherwise,the system version is lower than iOS8.
    if([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        
        NSLog(@"Yeah,Support touch ID");
        
        //if return yes,whether your fingerprint correct.
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按下指纹,开始爱爱吧！" reply:^(BOOL success, NSError * _Nullable error) {
            if (success)
            {
                [self imageViewShowAnimation];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self alertViewWithEnterPassword:YES];
                });
                
                NSLog(@"fail");
            }
        }];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self alertViewWithEnterPassword:YES];
        });
        
        NSLog(@"Sorry,The device doesn't support touch ID");
    }
    
}

//if it is not support touch ID,then input password
- (void)alertViewWithEnterPassword:(BOOL)isTrue
{
    if (isTrue)
    {
        _alert = [UIAlertController alertControllerWithTitle:@"按下指纹" message:@"请重按手指" preferredStyle:UIAlertControllerStyleAlert];
    }
    else
    {
        _alert = [UIAlertController alertControllerWithTitle:@"认证失败" message:@"请使用正确的指纹" preferredStyle:UIAlertControllerStyleAlert];
    }
    
    
    UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"返回指纹" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_alert.textFields.firstObject];
        
        [self alertEvaluatePolicyWithTouchID];

    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_alert.textFields.firstObject];
        if ([_alert.textFields.firstObject.text isEqualToString:kUSERPASSWORD])
        {
            [self imageViewShowAnimation];
        }
        else
        {
            [self alertViewWithEnterPassword:NO];
        }
    }];
    
    confirmAction.enabled = NO;
    self.confirmAction = confirmAction;
    __weak typeof(self)weakSelf = self;
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(alertTextFieldChangeTextNotificationHandler:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    [_alert addAction:backAction];
    [_alert addAction:confirmAction];
    
    [self.rootViewController presentViewController:_alert animated:YES completion:nil];
}

- (void)alertTextFieldChangeTextNotificationHandler:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    self.confirmAction.enabled = textField.text.length > 5;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
