//
//  LoveLoveViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^onSuccess)(NSArray *imageArray);
typedef void(^onSuccess)(NSArray *videoArray);
typedef void(^onFailed)(NSError *error);

@interface DataManager : NSObject
/** 封面图片 */
@property(nonatomic,copy)NSArray *imageArray;
/** 视频列表 */
@property(nonatomic,copy)NSArray *videoArray;

+ (DataManager *)shareManager;

/** 封面图片 */
- (void)getPhotoAlbumListWithURLString:(NSString *)URLString success:(onSuccess)success failed:(onFailed)failed;
/** 视频列表 */
- (void)getVideoListWithURLString:(NSString *)URLString success:(onSuccess)success failed:(onFailed)failed;

@end
