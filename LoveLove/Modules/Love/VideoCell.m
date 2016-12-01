//
//  VideoCell.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)setModel:(VideoModel *)model {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = model.title;
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconBtn.layer.cornerRadius = 12.5;
    self.iconBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
