//
//  CollectionViewCell.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/28.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "CollectionCategoryModel.h"
#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4)];
        self.imageV.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

- (void)setModel:(SubCategoryModel *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
