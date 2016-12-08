//
//  PhotoAlbumViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/27.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "PhotoAlbumViewController.h"

#import "FXBlurView.h"
#import "AlbumCollectionViewLineLayout.h"
#import "MyLoveViewController.h"

static NSString *reuseIdentifier = @"Cell";

@interface PhotoAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AlbumCollectionViewLineLayout *lineLayout;
@property (nonatomic, assign) ItemSelectType ItemSelectType;
@property (nonatomic, assign) NSUInteger photoCounts;


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
    
    if (self.ItemSelectType == ItemSelectTypeOne) {
        self.photoCounts = 20;
    }else if (self.ItemSelectType == ItemSelectTypeTwo) {
        self.photoCounts = 39;
    }
    [self.contentView addSubview:self.collectionView];
}

#pragma mark init methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        if (self.ItemSelectType == ItemSelectTypeOne) {
            _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiamo%zi.jpg", 1 % self.photoCounts]];
        }
        if (self.ItemSelectType == ItemSelectTypeTwo) {
            _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"liu%zi.jpg", 1 % self.photoCounts]];
        }
        
        FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:_imageView.bounds];
        blurView.blurRadius = 10;
        blurView.tintColor = [UIColor clearColor];
        [_imageView addSubview:blurView];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _lineLayout = [[AlbumCollectionViewLineLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:_lineLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundView = self.imageView;
        [_collectionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
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
//    NSString *imageName1 = [NSString stringWithFormat:@"xiamo%zi.jpg", item%20];
    
    WS(weakSelf);
    [UIView animateWithDuration:.5f animations:^{
        
        if (self.ItemSelectType == ItemSelectTypeOne) {
            weakSelf.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiamo%zi.jpg", item % self.photoCounts]];
        }else if (self.ItemSelectType == ItemSelectTypeTwo) {
            weakSelf.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"liu%zi.jpg", item% self.photoCounts]];
        }
        
        
//        weakSelf.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiamo%zi.jpg", item%20]];
    }];
}

#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoCounts;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    NSString *imageName = [NSString stringWithFormat:@"xiamo%zi.jpg", indexPath.item % 20];
    
    if (self.ItemSelectType == ItemSelectTypeOne) {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiamo%zi.jpg", indexPath.item % self.photoCounts]];
    }else if (self.ItemSelectType == ItemSelectTypeTwo) {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"liu%zi.jpg", indexPath.item % self.photoCounts]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MyLoveViewController *loveVC = [[MyLoveViewController alloc] init];
    loveVC.index = (int)indexPath.row;
    loveVC.titles = self.titles;
    [self.navigationController pushViewController:loveVC animated:YES];
}

@end


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


