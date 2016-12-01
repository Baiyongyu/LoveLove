//
//  LoveLoveViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "DataManager.h"
#import "VideoModel.h"

@implementation DataManager

+ (DataManager *)shareManager {
    
    static DataManager* manager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (void)getVideoListWithURLString:(NSString *)URLString success:(onSuccess)success failed:(onFailed)failed {
    dispatch_queue_t global_t = dispatch_get_global_queue(0, 0);
    dispatch_async(global_t, ^{
        NSMutableArray *videoArray = [NSMutableArray array];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *video in [dict objectForKey:@"videoList"]) {
                VideoModel *model = [[VideoModel alloc] init];
                [model setValuesForKeysWithDictionary:video];
                [videoArray addObject:model];
            }
            self.videoArray = [NSArray arrayWithArray:videoArray];

            success(videoArray);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });
}

@end
