//
//  PhotoAlbumViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/27.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "PhotoAlbumViewController.h"

#import "FXBlurView.h"
#import "CollectionViewCell.h"
#import "CollectionViewLineLayout.h"

#import "MyLoveViewController.h"

static NSString *reuseIdentifier = @"Cell";

@interface PhotoAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CollectionViewLineLayout *lineLayout;
@property (nonatomic, assign) ItemSelectType ItemSelectType;


@end

@implementation PhotoAlbumViewController

- (instancetype)initWithItemSelectType:(ItemSelectType)itemSelectType {
    if (self = [super init]) {
        _ItemSelectType = itemSelectType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.titles;
    self.leftBtn.hidden = NO;
    
    [self.contentView addSubview:self.collectionView];
}


#pragma mark init methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"p%zi.jpg", 7 % 20]];
        FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:_imageView.bounds];
        blurView.blurRadius = 10;
        blurView.tintColor = [UIColor clearColor];
        [_imageView addSubview:blurView];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _lineLayout = [[CollectionViewLineLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:_lineLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundView = self.imageView;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:7 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = self.lineLayout.itemSize.width + self.lineLayout.minimumLineSpacing;
    NSInteger item = offsetX/width;
    NSString *imageName1 = [NSString stringWithFormat:@"p%zi.jpg", item%20];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5f animations:^{
        weakSelf.imageView.image = [UIImage imageNamed:imageName1];
    }];
}

#pragma mark -
#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"p%zi.jpg", indexPath.item % 20];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MyLoveViewController *loveVC = [[MyLoveViewController alloc] init];
    loveVC.index = (int)indexPath.row;
    loveVC.titles = self.titles;
    [self.navigationController pushViewController:loveVC animated:YES];
}

@end
