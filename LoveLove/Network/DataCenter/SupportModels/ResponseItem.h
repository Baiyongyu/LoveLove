//
//  ResponseItem.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestItem.h"

@interface ResponseItem : NSObject

@property (nonatomic, strong) NSString *oriResponseString;  // 原始返回的JSON串
@property (nonatomic, strong) RequestItem *requestItem;     // 请求时候的对象
@property (nonatomic, strong) NSString *returnCode;         // 返回的错误码
@property (nonatomic, strong) NSString *errorInfo;          // 错误描述
@property (nonatomic, strong) NSString *status;             // 返回的status
@property (nonatomic, strong) NSDictionary *responseDict;   // 请求返回的字典数据
@property (nonatomic, strong) NSMutableArray *responseArray;       // data中返回数组数据

//@property (nonatomic, strong) NSMutableArray *returnDataArray;   // 存数据模型Item

+ (instancetype)responseItemWithRequestItem:(RequestItem *)requestItem
                           responseJSONData:(NSData *)jsonData;

@end
