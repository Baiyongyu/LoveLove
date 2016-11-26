//
//  HomeHeaderView.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"               // 滚动视图
#import "QMNavigateCollectionViewCell.h"
#import "WaterLayoutViewController.h"       // 美女流

@interface HomeHeaderView () <SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong) UIView *bgView;
/** collevtionView */
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kDefaultViewBackgroundColor;
//        [self layoutConstraints];
    }
    return self;
}

- (void)layoutConstraints {
    // 背景视图
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 248)];
    self.bgView.backgroundColor = kDefaultViewBackgroundColor;
    [self addSubview:self.bgView];
    
    // ScrollView
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) delegate:self placeholderImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.autoScrollTimeInterval = 3;
    
    NSArray *imgArray = @[@"http://img.zngirls.com/gallery/19705/19815/s/0.jpg",
                          @"http://img.zngirls.com/gallery/19705/19815/s/001.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imgArray;
    });
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    [self.bgView addSubview:cycleScrollView];
    
    // CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), SCREEN_WIDTH, 88) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, 88);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"QMNavigateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NavCell"];
    [self.bgView addSubview:self.collectionView];
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QMNavigateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NavCell" forIndexPath:indexPath];
    [cell setImageForCellWithIndexpath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    WaterLayoutViewController *waterVC = [[WaterLayoutViewController alloc] init];
//    waterVC.index = (int)indexPath.row + 1;
//    [self.navigationController pushViewController:waterVC animated:YES];
}

@end
