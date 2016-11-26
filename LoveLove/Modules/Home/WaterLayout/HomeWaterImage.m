//
//  XRImage.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "HomeWaterImage.h"

@implementation HomeWaterImage
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    HomeWaterImage *image = [[HomeWaterImage alloc] init];
    image.imageURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;
}
@end
