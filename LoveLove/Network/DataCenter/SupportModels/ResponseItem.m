//
//  ResponseItem.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ResponseItem.h"
#import "DataParser.h"

@implementation ResponseItem

- (instancetype)initWithRequestItem:(RequestItem *)requestItem responseJSONData:(NSData *)jsonData {
    if (self = [super init]) {
        
        if ([jsonData isKindOfClass:[NSError class]]) {
            self.requestItem = requestItem;
            self.status = @"";
            self.errorInfo = @"网络连接错误";
            self.returnCode = @"0";
            return self;
        }
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        self.oriResponseString = jsonStr;
        self.requestItem = requestItem;
        NSDictionary *dict = [DataParser parseOpenAPIResult:jsonData];
        if (dict) {
            
            self.errorInfo = [NSString stringWithFormat:@"%@", [dict objectForKey:@"statusInfo"]];
            self.status = [NSString stringWithFormat:@"%@", [dict objectForKey:@"status"]];
            
//            if ([self.status isEqualToString:@"7001"]) {
//                [AppCommon toast:Tip_RequestUnlegal];
//                [AppCommon pushWithVCClassName:@"LoginViewController"];
//            }
            
            id data = [dict objectForKey:@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                self.responseDict = data;
            } else if ([data isKindOfClass:[NSArray class]]) {
                self.responseArray = data;
            }else{
                self.responseDict = dict;
            }
        }
    }
    return self;
}
+ (instancetype)responseItemWithRequestItem:(RequestItem *)requestItem
                           responseJSONData:(NSData *)jsonData {
    return [[self alloc] initWithRequestItem:requestItem responseJSONData:jsonData];
}


@end
