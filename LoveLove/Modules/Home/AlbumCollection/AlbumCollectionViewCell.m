//
//  CollectionViewCell.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/27.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "AlbumCollectionViewCell.h"

@implementation AlbumCollectionViewCell

#pragma mark -
#pragma mark init methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setAppModel:(AppModel *)appModel {
    _appModel = appModel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:appModel.image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}


@end
