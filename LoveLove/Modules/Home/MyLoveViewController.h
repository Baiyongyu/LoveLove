//
//  MyLoveViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComBaseViewController.h"

#import "AppModel.h"

@interface MyLoveViewController : ComBaseViewController
@property (nonatomic, assign)int index;
@end

@interface MyCell : UITableViewCell
/** 图片imgView */
@property (nonatomic, strong) UIImageView *pictureView;
/** 标题label */
@property (nonatomic, strong) UILabel *titleLabel;
/** 内容Label */
@property (nonatomic, strong) UILabel *littleLabel;
/** 遮挡的View */
@property (nonatomic, strong) UIView *coverview;
/** cell的位移 */
- (CGFloat)cellOffset;

@property (nonatomic, strong) AppModel *appModel;

@end
