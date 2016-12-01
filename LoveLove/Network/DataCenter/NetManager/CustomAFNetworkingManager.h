//
//  CustomAFNetworkingManager.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestItem.h"
#import "ResponseItem.h"

@interface CustomAFNetworkingManager : NSObject

#pragma mark 外部DataCenter调用
+ (instancetype)sharedInstance;

/**
 *  发起网络请求
 *
 *  @param requestItem 请求模型
 *
 *  @return 请求结果
 */
- (int)sendRequestWithRequestItem:(RequestItem *)requestItem;

@end
