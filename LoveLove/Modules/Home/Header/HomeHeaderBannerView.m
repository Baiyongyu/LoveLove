//
//  HomeHeaderBannerView.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "HomeHeaderBannerView.h"
#import "SDCycleScrollView.h"               // 滚动视图
#import "ComWebViewController.h"
#import "QMNavigateCollectionViewCell.h"

#import "PhotoAlbumViewController.h"


@interface HomeHeaderBannerView () <SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
/** 背景 */
@property (nonatomic, strong) UIView *bgView;
/** banner */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/** collection背景图 */
@property (nonatomic, strong) UIImageView *bgImgView;
/** collevtionView */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HomeHeaderBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self layoutConstraints];
    }
    return self;
}

- (void)layoutConstraints {
    
    /** 头视图 背景View */
    [self addSubview:self.bgView];
    /** ScrollView */
    [self.bgView addSubview:self.cycleScrollView];
    /** collection */
    [self.bgView addSubview:self.bgImgView];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"index=%ld", index);
    
    ComWebViewController *webVC = [[ComWebViewController alloc] init];
    webVC.urlStr = @"http://www.zngirls.com/g/17807/";
    [kRootNavigation pushViewController:webVC animated:YES];
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
    switch (indexPath.row) {
        case 0:
        {
            PhotoAlbumViewController *waterVC = [[PhotoAlbumViewController alloc] initWithItemSelectType:ItemSelectTypeOne];
            waterVC.titles = @"夏茉";
            [kRootNavigation pushViewController:waterVC animated:YES];
        }
            break;
        case 1:
        {
            PhotoAlbumViewController *waterVC = [[PhotoAlbumViewController alloc] initWithItemSelectType:ItemSelectTypeTwo];
            waterVC.titles = @"刘飞儿";
            [kRootNavigation pushViewController:waterVC animated:YES];
        }
            break;
        case 2:
        {
            [MBProgressHUD showTip:@"暂未开放、敬请期待！"];
        }
            break;
        case 3:
        {
            [MBProgressHUD showTip:@"暂未开放、敬请期待！"];
        }
            break;
        case 4:
        {
            [MBProgressHUD showTip:@"暂未开放、敬请期待！"];
        }
            break;
        default:
            break;
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + 88)];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.autoScrollTimeInterval = 3;
//        _cycleScrollView.layer.cornerRadius = 5.0f;
//        _cycleScrollView.layer.masksToBounds = YES;
        
        NSArray *imgArray = @[@"http://img.zngirls.com/gallery/21337/17758/003.jpg",
                              @"http://img.zngirls.com/gallery/19705/19815/004.jpg"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _cycleScrollView.imageURLStringsGroup = imgArray;
        });
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
    }
    return _cycleScrollView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 88)];
        _bgImgView.image = [UIImage imageNamed:@"icon_arc+rectangle8"];
        _bgImgView.alpha = 0.8f;
        _bgImgView.contentMode = UIViewContentModeScaleToFill;
        _bgImgView.userInteractionEnabled = YES;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4, 88);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"QMNavigateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NavCell"];
        [_bgImgView addSubview:_collectionView];
    }
    return _bgImgView;
}

@end
