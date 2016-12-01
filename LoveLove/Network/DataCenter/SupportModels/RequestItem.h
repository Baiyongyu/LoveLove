//
//  RequestItem.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadFileItem.h"

typedef NS_ENUM(NSInteger, kReturnCode) {
    kReturnCodeRequestFail          = 1,                    // 请求失败
    kReturnCodeRequestSuccess       = 0,                    // 请求成功
    //code： 0       msg:成功
    //code： 1       msg:失败
};


typedef NS_ENUM(NSInteger, kHttpMethodType) {
    kHttpMethodTypeGet = 1,
    kHttpMethodTypePost
};

@interface RequestItem : NSObject

@property (nonatomic, assign) kHttpMethodType httpMethodType;    // 请求方式get/post
@property (nonatomic, assign) SEL requestSuccessSEL;             // 请求成功回调方法
@property (nonatomic, assign) SEL requestFailSEL;                // 请求失败回调方法
@property (nonatomic, strong) NSString *requestUrl;              // 请求地址
@property (nonatomic, weak) id delegateTarget;                   // 发起请求的对象
@property (nonatomic, weak) id targetCenter;                     // 响应事件的DataCenter
@property (nonatomic, assign) SEL parseMethod;                   // 对应解析方法
@property (nonatomic, strong) NSDictionary *postParamDict;       // POST请求参数
@property (nonatomic, strong) NSDictionary *requestHeader;       // 请求头
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) UploadFileItem *uploadItem;

@end
