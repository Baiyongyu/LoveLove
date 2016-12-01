//
//  NoDataView.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView()

@end

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIImageView *wifeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - [UIImage imageNamed:@"noNekwork"].size.width)/2.0, 100, [UIImage imageNamed:@"noNekwork"].size.width, [UIImage imageNamed:@"noNekwork"].size.height)];
    wifeImageView.image = [UIImage imageNamed:@"noNekwork"];
    [self addSubview:wifeImageView];
}

- (void)reloadButtonAction {
    if (self.reloadNewDataBlock) {
        self.reloadNewDataBlock();
    }
}
@end
