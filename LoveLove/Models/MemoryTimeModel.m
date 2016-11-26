//
//  HappyTimeModel.m
//  WeLove
//
//  Created by 宇玄丶 on 16/11/18.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import "MemoryTimeModel.h"

@implementation MemoryTimeModel

- (id)copyWithZone:(NSZone *)zone
{
    MemoryTimeModel *newItem = [[MemoryTimeModel allocWithZone:zone] init];
    newItem.time = self.time;
    newItem.titleName = self.titleName;
    newItem.detailInfo = self.detailInfo;
    newItem.pictureArray = [self.pictureArray copy];
    newItem.contentHeight = self.contentHeight;
    return newItem;
}

@end

