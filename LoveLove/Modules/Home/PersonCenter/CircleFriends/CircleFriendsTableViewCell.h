//
//  CircleFriendsTableViewCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDTimeLineCellModel.h"
#import "SDWeiXinPhotoContainerView.h"
@interface CircleFriendsTableViewCell : UITableViewCell
@property (nonatomic, strong) SDTimeLineCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, strong) UILabel *timeLabel;

@end
