//
//  WaterLayoutViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "WaterLayoutViewController.h"

#import "WaterCollectionViewCell.h"
#import "WaterfallLayout.h"
#import "HomeWaterImage.h"
#import "MyLoveViewController.h"
#import "ToViewTopButton.h"                 // 回到顶部

@interface WaterLayoutViewController () <UICollectionViewDataSource,UICollectionViewDelegate,WaterfallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<HomeWaterImage *> *images;
@property (nonatomic, assign) ItemSelectType ItemSelectType;

@end

@implementation WaterLayoutViewController

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
}

- (void)layoutConstraints {
    //创建瀑布流布局
    WaterfallLayout *waterfall = [WaterfallLayout waterFallLayoutWithColumnCount:2];
    //或者一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    //设置代理，实现代理方法
    waterfall.delegate = self;
    //或者设置block
    [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
        //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
        HomeWaterImage *image = self.images[indexPath.item];
        return image.imageH / image.imageW * itemWidth;
    }];
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 44) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.contentView addSubview:self.collectionView];
    
    /***************************回到顶部*****************************/
    ToViewTopButton *topButton = [[ToViewTopButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, SCREEN_HEIGHT - 64, 45, 45) scrollView:(UIScrollView *)self.collectionView];
    topButton.showBtnOffset = 350;
    [self.view addSubview:topButton];
}
- (void)click {
    [self.images removeAllObjects];
    [self.collectionView reloadData];
}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(WaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    HomeWaterImage *image = self.images[indexPath.item];
    return image.imageH / image.imageW * itemWidth;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageURL = self.images[indexPath.item].imageURL;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyLoveViewController *loveVC = [[MyLoveViewController alloc] init];
    loveVC.index = (int)indexPath.row + 1;
    loveVC.titles = self.titles;
    [self.navigationController pushViewController:loveVC animated:YES];
}

- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WaterList1.plist" ofType:nil];
        
//        NSString *path = [NSString stringWithFormat:@"%@p.png"];
        
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *imageDic in imageDics) {
            HomeWaterImage *image = [HomeWaterImage imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
