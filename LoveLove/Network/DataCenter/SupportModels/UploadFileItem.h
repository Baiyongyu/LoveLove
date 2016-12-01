//
//  UploadFileItem.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kHttpRequestMode) {
    kHttpRequestModeDefault = 1,            // 默认
    kHttpRequestModeUpload = 2,             // 单张图片
    kHttpRequestModeMultiPictureUpload = 3, // 多图片
};

@interface UploadFileItem : NSObject

@property (nonatomic, assign) kHttpRequestMode httpRequestMode;   // 标记请求类型为普通或数据上传
@property (nonatomic, strong) NSString *name;                     // 服务器名
@property (nonatomic, strong) NSData *uploadData;                 // 上传数据
@property (nonatomic, strong) NSMutableArray *uploadMutiDataList; // 多图片上传
@property (nonatomic, strong) NSString *fileName;                 // 上传文件名
@property (nonatomic, strong) NSString *mimeType;                 // mimeType

@end
