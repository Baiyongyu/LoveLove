//
//  CollectionViewCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/27.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@interface AlbumCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) AppModel *appModel;

@end
