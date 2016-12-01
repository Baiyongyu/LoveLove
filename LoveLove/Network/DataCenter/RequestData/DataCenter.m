//
//  DataCenter.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "DataCenter.h"
#import "CustomAFNetworkingManager.h"

@implementation DataCenter

static DataCenter *_dataCenter = nil;
+ (instancetype)sharedDataCenter {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _dataCenter = [[DataCenter alloc] init];
    });
    return _dataCenter;
}

- (int)sendRequestWithRequestItem:(RequestItem *)item {
    return [[CustomAFNetworkingManager sharedInstance] sendRequestWithRequestItem:item];
}

#pragma mark - 向上层发送返回结果
- (void)sendSuccessResponseItem:(ResponseItem *)responseItem {
    if (responseItem.requestItem.delegateTarget && [responseItem.requestItem.delegateTarget respondsToSelector:responseItem.requestItem.requestSuccessSEL]) {
        [responseItem.requestItem.delegateTarget performSelector:responseItem.requestItem.requestSuccessSEL withObject:responseItem afterDelay:0.0];
    }
}

- (void)sendFailResponseItem:(ResponseItem *)responseItem {
    if (responseItem.requestItem.delegateTarget && [responseItem.requestItem.delegateTarget respondsToSelector:responseItem.requestItem.requestFailSEL]) {
        [responseItem.requestItem.delegateTarget performSelector:responseItem.requestItem.requestFailSEL withObject:responseItem afterDelay:0.0];
    }
}

@end
