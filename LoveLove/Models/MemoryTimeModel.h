//
//  HappyTimeModel.h
//  WeLove
//
//  Created by 宇玄丶 on 16/11/18.
//  Copyright © 2016年 ahqianmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MemoryTimeModel : NSObject

// 时间
@property(nonatomic,copy)NSString *time;
// 标题
@property(nonatomic,copy)NSString *titleName;
// 详情
@property(nonatomic,copy)NSString *detailInfo;
// 图片
@property(nonatomic,copy)NSString *imgUrl;
// 图片视频数组
@property(nonatomic,copy)NSArray *pictureArray;
// 内容高度
@property(nonatomic,assign)CGFloat contentHeight;

@end


