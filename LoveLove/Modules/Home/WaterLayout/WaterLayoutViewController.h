//
//  WaterLayoutViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "ComBaseViewController.h"

// 判断点击了那个item
typedef NS_ENUM(NSInteger , ItemSelectType) {
    ItemSelectTypeOne = 0,
    ItemSelectTypeTwo,
    ItemSelectTypeThree,
    ItemSelectTypeFore,
    ItemSelectTypeFive,
    ItemSelectTypeSix,
    ItemSelectTypeSeven,
    ItemSelectTypeEight
};

@interface WaterLayoutViewController : ComBaseViewController
@property (nonatomic, copy) NSString *titles;

/** 从哪个页面到这个界面 */
- (instancetype)initWithItemSelectType:(ItemSelectType)itemSelectType;
@end
