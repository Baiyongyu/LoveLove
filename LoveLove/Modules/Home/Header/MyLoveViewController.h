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
@property (nonatomic, copy) NSString *titles;
@property (nonatomic, copy) NSString *parent_id;
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

- (void)ShowImage:(NSString *)models nameNV:(NSString *)nameNV;

@property (nonatomic, strong) AppModel *appModel;

@property (nonatomic,copy)NSString * imageName;
@property (nonatomic,assign)float CellHeight;
@property (nonatomic,assign)float CellWeigh;
@property (nonatomic,assign)float BiLi;
@property (nonatomic,strong)NSMutableArray *arr;

@end
