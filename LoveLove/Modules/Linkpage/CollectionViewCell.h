//
//  CollectionViewCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/28.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_CollectionView @"CollectionViewCell"

@class SubCategoryModel;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SubCategoryModel *model;

@end