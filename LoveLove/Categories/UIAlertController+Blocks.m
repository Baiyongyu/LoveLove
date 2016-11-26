//
//  UIAlertController+Blocks.m
//  INongBao
//
//  Created by 宇玄丶 on 16/7/2.
//  Copyright © 2016年 common. All rights reserved.

#import "UIAlertController+Blocks.h"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;
static NSInteger const UIAlertControllerBlocksSecondOtherButtonIndex = 3;

@implementation UIAlertController (Blocks)

+ (instancetype)showInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
#if TARGET_OS_IOS
  popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
#endif
                            tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    __weak UIAlertController *controller = strongController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 if (tapBlock) {
                                                                     tapBlock(controller, action, UIAlertControllerBlocksCancelButtonIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      if (tapBlock) {
                                                                          tapBlock(controller, action, UIAlertControllerBlocksDestructiveButtonIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                if (tapBlock) {
                                                                    tapBlock(controller, action, UIAlertControllerBlocksFirstOtherButtonIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }
    
#if TARGET_OS_IOS
    if (popoverPresentationControllerBlock) {
        popoverPresentationControllerBlock(controller.popoverPresentationController);
    }
#endif
    
    [viewController presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                 tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                       preferredStyle:UIAlertControllerStyleAlert
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
#if TARGET_OS_IOS
            popoverPresentationControllerBlock:nil
#endif
                             tapBlock:tapBlock];
}

+ (instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
#if TARGET_OS_IOS
             popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
#endif
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                       preferredStyle:UIAlertControllerStyleActionSheet
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
#if TARGET_OS_IOS
            popoverPresentationControllerBlock:popoverPresentationControllerBlock
#endif
                             tapBlock:tapBlock];
}

#pragma mark -
- (BOOL)visible {
    return self.view.superview != nil;
}

- (NSInteger)cancelButtonIndex {
    return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex {
    return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)secondOtherButtonIndex {
    return UIAlertControllerBlocksSecondOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex {
    return UIAlertControllerBlocksDestructiveButtonIndex;
}

@end
