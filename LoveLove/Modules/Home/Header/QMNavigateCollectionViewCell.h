//
//  QMNavigateCollectionViewCell.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMNavigateCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath;
@end
