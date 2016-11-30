//
//  HomeHeaderView.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/28.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "HomeHeaderView.h"
#import "FXBlurView.h"
#import "AlbumCollectionViewCell.h"
#import "AlbumCollectionViewLineLayout.h"
#import "PhotoAlbumViewController.h"


static NSString *reuseIdentifier = @"Cell";
static NSString *headerViewIdentifier = @"hederview";
@interface HomeHeaderView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AlbumCollectionViewLineLayout *lineLayout;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        
        // 刚进入界面时动画展示
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.25;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1f, 0.1f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
        popAnimation.keyTimes = @[@0.2f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.collectionView.layer addAnimation:popAnimation forKey:nil];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"xiamo%zi.jpg", 2 % 20]];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)
                                             collectionViewLayout:_lineLayout];
        
        _lineLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _lineLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 250);
        _lineLayout.minimumLineSpacing = 50;
        _lineLayout.minimumInteritemSpacing = 50;
        _lineLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundView = self.imageView;
        [_collectionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]
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
    NSString *imageName1 = [NSString stringWithFormat:@"xiamo%zi.jpg", item % 20];
    
    WS(weakSelf);
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.imageView.image = [UIImage imageNamed:imageName1];
    }];
}

#pragma mark -
#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"xiamo%zi.jpg", indexPath.item % 20];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(didSeletedViewItem:)]) {
        [_delegate didSeletedViewItem:indexPath];
    }
}

@end
