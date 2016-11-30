//
//  CircleFriendsTableViewCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDTimeLineCellModel.h"
#import "SDWeiXinPhotoContainerView.h"

/** 图片block */
typedef void(^PhotoTapBlock)();


@interface CircleFriendsTableViewCell : UITableViewCell
@property (nonatomic, strong) SDTimeLineCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic,copy) PhotoTapBlock photoTapBlock;

@end
