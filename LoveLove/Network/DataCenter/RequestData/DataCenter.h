//
//  DataCenter.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseItem.h"

@interface DataCenter : NSObject

+ (instancetype)sharedDataCenter;

- (int)sendRequestWithRequestItem:(RequestItem *)item;

#pragma mark - 向上层发送返回结果
- (void)sendSuccessResponseItem:(ResponseItem *)item;
- (void)sendFailResponseItem:(ResponseItem *)item;

@end
