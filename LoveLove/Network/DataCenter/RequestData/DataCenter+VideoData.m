//
//  DataCenter+VideoData.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "DataCenter+VideoData.h"
#import "VideoModel.h"
@implementation DataCenter (VideoData)

#pragma mark -- 获取爱爱页面视频列表
- (int)sendVideoListRequestTarget:(id)delegateTarget
                       successSEL:(SEL)successSEL
                          failSEL:(SEL)failSEL {
    RequestItem *requestItem = [[RequestItem alloc] init];
    requestItem.httpMethodType = kHttpMethodTypePost;
    requestItem.delegateTarget = delegateTarget;
    requestItem.requestSuccessSEL = successSEL;
    requestItem.requestFailSEL = failSEL;
    requestItem.targetCenter = self;
    
//    requestItem.requestUrl = [NSString stringWithFormat:@"%@address/isdefault",BaseUrl];
    requestItem.requestUrl = @"http://c.m.163.com/nc/video/home/0-10.html";
    
    requestItem.parseMethod = @selector(parseVideoListRequestData:);
    return [self sendRequestWithRequestItem:requestItem];
}

- (void)parseVideoListRequestData:(ResponseItem *)responseItem {
    NSInteger returnCode = responseItem.returnCode.integerValue;
    if (returnCode != kReturnCodeRequestSuccess ) {
        [self sendFailResponseItem:responseItem];
        return;
    }
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in responseItem.responseArray) {
        VideoModel *videoModel = [[VideoModel alloc] init];
        videoModel.cover = dict[@"cover"];
        videoModel.descriptionDe = dict[@"descriptionDe"];
        videoModel.m3u8_url = dict[@"m3u8_url"];
        videoModel.m3u8Hd_url = dict[@"m3u8Hd_url"];
        videoModel.mp4_url = dict[@"mp4_url"];
        videoModel.mp4_Hd_url = dict[@"mp4_Hd_url"];
        videoModel.playersize = dict[@"playersize"];
        videoModel.ptime = dict[@"ptime"];
        videoModel.replyBoard = dict[@"replyBoard"];
        videoModel.replyCount = dict[@"replyCount"];
        videoModel.replyid = dict[@"replyid"];
        videoModel.title = dict[@"title"];
        videoModel.vid = dict[@"vid"];
        videoModel.videosource = dict[@"videosource"];
        [dataArray addObject:videoModel];
    }
    responseItem.responseArray = dataArray;
    
    [self sendSuccessResponseItem:responseItem];
}

@end
