//
//  LoveLoveViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^onSuccess)(NSArray *videoArray);
typedef void(^onFailed)(NSError *error);

@interface DataManager : NSObject

@property(nonatomic,copy)NSArray *videoArray;

+ (DataManager *)shareManager;

- (void)getVideoListWithURLString:(NSString *)URLString success:(onSuccess)success failed:(onFailed)failed;

@end
