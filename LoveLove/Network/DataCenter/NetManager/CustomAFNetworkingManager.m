//
//  CustomAFNetworkingManager.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "CustomAFNetworkingManager.h"

#define K_Error_Request         -1
#define K_Success_Request       0
#define K_Fail_Request          1

@implementation CustomAFNetworkingManager

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

static CustomAFNetworkingManager *_manager = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _manager = [[CustomAFNetworkingManager alloc] init];
    });
    return _manager;
}

- (BOOL)checkNetIsEnable {
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (BOOL)checkRequestItem:(RequestItem *)item {
    if (!item.requestUrl) {
        NSLog(@"Error:请求URL为空");
        return NO;
    }
    if (!item.parseMethod) {
        NSLog(@"Error:使用通知回调，解析方法不能为空");
        return NO;
    }
    return YES;
}

- (int)sendRequestWithRequestItem:(RequestItem *)requestItem {
    if (![self checkRequestItem:requestItem]) {
        return K_Error_Request;
    }
    __block int status = K_Fail_Request;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    // 网络超时
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 去除掉值为null的键值对
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/xml",@"text/javascript", nil];
    
    //    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    for (NSString *key in [requestItem.requestHeader allKeys]) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [requestItem.requestHeader objectForKey:key]] forHTTPHeaderField:key];
    }
    if (requestItem.httpMethodType == kHttpMethodTypePost) {
        [manager POST:requestItem.requestUrl parameters:requestItem.postParamDict constructingBodyWithBlock:^(id<AFMultipartFormData > _Nonnull formData) {
            if (requestItem.uploadItem.httpRequestMode == kHttpRequestModeUpload) {
                [formData appendPartWithFileData:requestItem.uploadItem.uploadData name:requestItem.uploadItem.name fileName:requestItem.uploadItem.fileName mimeType:requestItem.uploadItem.mimeType];
            } else if (requestItem.uploadItem.httpRequestMode == kHttpRequestModeMultiPictureUpload){//多图片上传
                
                for (int i = 0; i < requestItem.uploadItem.uploadMutiDataList.count; i ++) {
                    [formData appendPartWithFileData:[requestItem.uploadItem.uploadMutiDataList objectAtIndex:i] name:[NSString stringWithFormat:@"%@%d",requestItem.uploadItem.name,i] fileName:requestItem.uploadItem.fileName mimeType:requestItem.uploadItem.mimeType];
                }

            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            status = K_Success_Request;
            
            [self requestFinishedWithRequestResponseData:responseObject requestItem:requestItem];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            requestItem.error=error;
            NSLog(@"fail error --> %@", error);
            
            [self requestFinishedWithRequestResponseData:error requestItem:requestItem];

        }];
//        [manager POST:requestItem.requestUrl
//           parameters:requestItem.postParamDict
//              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//                  status = K_Success_Request;
//                  
//                  [self requestFinishedWithRequestResponseData:responseObject requestItem:requestItem];
//              }
//              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                  requestItem.error=error;
//                  NSLog(@"fail error --> %@", error);
//                  
//                  [self requestFinishedWithRequestResponseData:error requestItem:requestItem];
//              }];
    } else if (requestItem.httpMethodType == kHttpMethodTypeGet) {
        [manager GET:requestItem.requestUrl parameters:requestItem.postParamDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            status = K_Success_Request;
            [self requestFinishedWithRequestResponseData:responseObject requestItem:requestItem];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"fail error --> %@", error);
            requestItem.error=error;
            [self requestFinishedWithRequestResponseData:error requestItem:requestItem];
        }];
//        [manager GET:requestItem.requestUrl
//          parameters:requestItem.postParamDict
//             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//                 status = K_Success_Request;
//                 [self requestFinishedWithRequestResponseData:responseObject requestItem:requestItem];
//             }
//             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                 NSLog(@"fail error --> %@", error);
//                 requestItem.error=error;
//                 [self requestFinishedWithRequestResponseData:error requestItem:requestItem];
//             }];
    }
    return status;
}
- (void)requestFinishedWithRequestResponseData:(id)responseData requestItem:(RequestItem *)requestItem {
    
    ResponseItem *responseItem = [ResponseItem responseItemWithRequestItem:requestItem responseJSONData:responseData];
    if (requestItem.targetCenter && [requestItem.targetCenter respondsToSelector:requestItem.parseMethod]) {
        [requestItem.targetCenter performSelector:requestItem.parseMethod withObject:responseItem afterDelay:0.0];
    }
}


@end
