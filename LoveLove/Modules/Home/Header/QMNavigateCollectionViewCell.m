//
//  QMNavigateCollectionViewCell.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "QMNavigateCollectionViewCell.h"

@interface QMNavigateCollectionViewCell()
@end

@implementation QMNavigateCollectionViewCell

- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath{
    NSArray *imageNameArray = [NSArray arrayWithObjects:
                               @"tool_button_home_nongzi_se",
                               @"tool_button_home_nongji_sel",
                               @"tool_button_home_nongshi_sel",
                               @"tool_button_home_daikuan_sel",
                               @"tool_button_home_nongzi_se",
                               @"tool_button_home_nongji_sel",
                               @"tool_button_home_nongshi_sel",
                               @"tool_button_home_daikuan_sel",
                               nil];
    
    NSArray *titleArray = [NSArray arrayWithObjects:
                           @"刘飞儿",
                           @"苍井空",
                           @"波多野结衣",
                           @"亚里沙",
                           @"饭岛爱",
                           @"爱池有沙",
                           @"泷泽萝拉",
                           @"小泽玛利亚",
                           nil];
    
    self.photoView.image = [UIImage imageNamed:imageNameArray[indexpath.row]];
    self.titleLabel.text = titleArray[indexpath.row];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
@end
