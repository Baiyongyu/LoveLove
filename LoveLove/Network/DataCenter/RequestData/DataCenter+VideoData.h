//
//  DataCenter+VideoData.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "DataCenter.h"

@interface DataCenter (VideoData)

#pragma mark -- 获取爱爱页面视频列表
- (int)sendVideoListRequestTarget:(id)delegateTarget
                                   successSEL:(SEL)successSEL
                                      failSEL:(SEL)failSEL;

@end
