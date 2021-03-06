//
//  VideoCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

typedef void (^IconActionBlock)();

@interface VideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (nonatomic, retain)VideoModel *model;

@property (nonatomic, copy) IconActionBlock iconActionBlock;

@end
