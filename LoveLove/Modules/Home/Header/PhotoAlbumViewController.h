//
//  PhotoAlbumViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/27.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComBaseViewController.h"
#import "AppModel.h"
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

@interface PhotoAlbumViewController : ComBaseViewController
@property (nonatomic, assign)int index;
@property (nonatomic, copy) NSString *titles;
/** 从哪个页面到这个界面 */
- (instancetype)initWithItemSelectType:(ItemSelectType)itemSelectType;
@end


@interface AlbumCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AppModel *appModel;

@end

