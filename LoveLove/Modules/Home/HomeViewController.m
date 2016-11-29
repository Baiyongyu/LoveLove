//
//  HomeViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "HomeViewController.h"

#import "SDCycleScrollView.h"               // 滚动视图
#import "QMNavigateCollectionViewCell.h"
#import "WaterLayoutViewController.h"       // 美女流
#import "PhotoAlbumViewController.h"
#import "MemeoryTimeTableViewController.h"  // 岁月
#import "HomeHeaderView.h"
#import "PersonCenterViewController.h"     // 个人资料详情
@interface HomeViewController () <SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate,DidSeletedViewItemDelegate>

@property (nonatomic, strong) UIView *bgView;
/** collevtionView */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MemeoryTimeTableViewController *memoryTimeTableVC;
@property (nonatomic, strong) HomeHeaderView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"首页";
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView addSubview:self.memoryTimeTableVC.view];
}


- (void)layoutConstraints {
    
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    bgImgView.image = [UIImage imageNamed:@"home_bkg_8_320x600_"];
//    [self.contentView addSubview:bgImgView];
    
    // 背景视图
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 268 + 88 + 300 + 30)];
    self.bgView.backgroundColor = kDefaultViewBackgroundColor;
    [self.contentView addSubview:self.bgView];
    
    // ScrollView
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 160) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.autoScrollTimeInterval = 3;
    cycleScrollView.layer.cornerRadius = 5.0f;
    cycleScrollView.layer.masksToBounds = YES;
    
    NSArray *imgArray = @[@"http://img.zngirls.com/gallery/21337/17758/003.jpg",
                          @"http://img.zngirls.com/gallery/19705/19815/s/008.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imgArray;
    });
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
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
    
    self.headerView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), SCREEN_WIDTH, 200)];
    [self.bgView addSubview:self.headerView];
    
    self.headerView.delegate = self;
    
    
    /**************************MemoryTimeTableVC*****************************/
    WS(weakSelf);
    [self.memoryTimeTableVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    self.memoryTimeTableVC.tableView.tableHeaderView = self.bgView;
    
    /***************************回到顶部*****************************/
    ToViewTopButton *topButton = [[ToViewTopButton alloc] initWithFrame:CGRectZero scrollView:(UIScrollView *)self.memoryTimeTableVC.view];
    topButton.showBtnOffset = 350;
    [self.view addSubview:topButton];
}
#pragma mark - 首页热门推荐item 代理
- (void)didSeletedViewItem:(NSIndexPath *)indexPath {
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
    
    personVC.scores = @[@(5),@(5),@(4),@(5),@(6)];
//    personVC.scores = @[@([self.scoreLabel1.text floatValue]),@([self.scoreLabel2.text floatValue]),@([self.scoreLabel3.text floatValue]),@([self.scoreLabel4.text floatValue]),@([self.scoreLabel5.text floatValue])];
//    personVC.compareScores =@[@([self.compareLabel1.text floatValue]),@([self.compareLabel2.text floatValue]),@([self.compareLabel3.text floatValue]),@([self.compareLabel4.text floatValue]),@([self.compareLabel5.text floatValue])];
    
    
    [self.navigationController pushViewController:personVC animated:YES];
    
    /*
    switch (indexPath.item) {
        case 0:
        {
            PhotoAlbumViewController *waterVC = [[PhotoAlbumViewController alloc] initWithItemSelectType:ItemSelectTypeOne];
            waterVC.titles = @"夏茉";
            [self.navigationController pushViewController:waterVC animated:YES];
        }
            break;
        case 1:
        {
            PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
            [self.navigationController pushViewController:personVC animated:YES];
//            PhotoAlbumViewController *waterVC = [[PhotoAlbumViewController alloc] initWithItemSelectType:ItemSelectTypeTwo];
//            waterVC.titles = @"刘飞儿";
//            [self.navigationController pushViewController:waterVC animated:YES];
        }
            break;
        case 2:
        {
            PhotoAlbumViewController *photoVC = [[PhotoAlbumViewController alloc] init];
            [self.navigationController pushViewController:photoVC animated:YES];
        }
            break;
        case 3:
        {
            PhotoAlbumViewController *photoVC = [[PhotoAlbumViewController alloc] init];
            [self.navigationController pushViewController:photoVC animated:YES];
        }
            break;
            
        default:
            break;
    }
     */
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
            [self.navigationController pushViewController:waterVC animated:YES];
        }
            break;
        case 1:
        {
            PhotoAlbumViewController *waterVC = [[PhotoAlbumViewController alloc] initWithItemSelectType:ItemSelectTypeTwo];
            waterVC.titles = @"刘飞儿";
            [self.navigationController pushViewController:waterVC animated:YES];
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

- (void)loadData {
    
    MemoryTimeModel *activityData7 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData7 ActivityTime:@"1986-01-08" activityName:@"小泽玛利亚" activityDetailInfo:@"小泽玛利亚（日语：小泽マリア、おざわ まりあ，英语：Ozawa Maria），1986年1月8日出生于日本北海道，混血儿（父亲是法裔加拿大人，母亲是日本人），日本AV女优。"];
    
    MemoryTimeModel *activityData6 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData6 ActivityTime:@"1992-6-" activityName:@"泷泽萝拉" activityDetailInfo:@"水咲萝拉（水咲ローラ），原名泷泽萝拉，1992年6月出生于日本东京，日本女演员、AV女优。水咲萝拉因在YOUTUBE上传各种卖萌的蹲姿自拍照而走红。2012年7月，她推出自己的第一部AV作品。2013年4月，泷泽萝拉改名“水咲萝拉”。"];
    
    MemoryTimeModel *activityData5 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData5 ActivityTime:@"1991-11-30" activityName:@"爱沢有纱" activityDetailInfo:@"爱泽有沙（Aizawa Arisa），1991年11月30日出生于日本神奈川县，av女优。"];
    
    MemoryTimeModel *activityData4 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData4 ActivityTime:@"1972-10-31" activityName:@"饭岛爱" activityDetailInfo:@"饭岛爱，日本女演员、前AV电影女优，1972年10月31日出生于东京都 江东区龟户。1992年饭岛爱参加东京电视台深夜节目《东京情色派》的“丁字裤小爱”单元的演出，在该节目中自掀裙子露出丁字裤，被称为“丁字裤女王”而成名，踏入日本演艺圈。"];
    
    MemoryTimeModel *activityData3 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData3 ActivityTime:@"1989-3-2" activityName:@"亚里沙" activityDetailInfo:@"亚里沙又名亚理纱（1989年3月2日－），日本福冈县出身的写真偶像、女演员。2011年3月于青山学院大学毕业，于IT企业就职。半年后在涉谷被星探发现，由OL转变为女演员，于2012年发表一本写真集《ALiSA》和两支DVD写真。"];
    
    MemoryTimeModel *activityData2 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData2 ActivityTime:@"1988-05-24" activityName:@"波多野结衣" activityDetailInfo:@"波多野结衣（はたの ゆい），女，1988年5月24日出生于日本京都府，著名日本女演员、AV女优。2008年，波多野结衣开始从事AV出演。2014年，她获得“年度最佳AV女优”奖。"];
    
    MemoryTimeModel *activityData1 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData1 ActivityTime:@"1983-11-11" activityName:@"苍井空" activityDetailInfo:@"苍井空，1983年11月11日出生于日本东京。日本AV女演员、成人模特，兼电视、电影演员。日本女子组合惠比寿麝香葡萄的初代首领，现成员、OG首领。其后不久，刚满18岁的苍井空在涩谷街头被星探发现，权衡再三后进入AV界发展。"];

    MemoryTimeModel *activityData0 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData0 ActivityTime:@"1993-03-14" activityName:@"刘飞儿" activityDetailInfo:@"刘飞儿，女，2007年第四十七届国际小姐中国冠军、中华慈善总会授予“爱心使者”称号；香港中华环境保护志愿者协会“环保公益事业形象大使”。"];
    
    self.memoryTimeTableVC.dataArray = [@[activityData0, activityData1, activityData2, activityData3, activityData4, activityData5, activityData6, activityData7] mutableCopy];
}

#pragma mark - 首页加载幸福时光数据封装
- (void)loadActivityData:(MemoryTimeModel *)happyData ActivityTime:(NSString *)activityTime activityName:(NSString *)activityName activityDetailInfo:(NSString *)activityDetailInfo {
    
    happyData.time = activityTime;
    happyData.titleName = activityName;
    happyData.detailInfo = activityDetailInfo;
    
    // 布局计算
    CGFloat height = 85;
    CGSize activityNameSize = [QMUtil sizeWithString:happyData.titleName font:XiHeiFont(16) size:CGSizeMake(SCREEN_WIDTH-100, CGFLOAT_MAX)];
    if(activityNameSize.height>20)
    {
        height += (activityNameSize.height-20);
    }
    CGSize activityDetailSize = [QMUtil sizeWithString:happyData.detailInfo font:XiHeiFont(16) size:CGSizeMake(SCREEN_WIDTH-100, CGFLOAT_MAX)];
    height += activityDetailSize.height;
    if (happyData.pictureArray.count) {
        CGFloat itemHeight = (SCREEN_WIDTH-100-20)/3;
        if (happyData.pictureArray.count%3==0) {
            height += (happyData.pictureArray.count/3-1)*10 + (happyData.pictureArray.count/3)*itemHeight;
        } else {
            height += happyData.pictureArray.count/3*10 + (happyData.pictureArray.count/3+1)*itemHeight;
        }
        height += 15;
    }
    happyData.contentHeight = height;
}

#pragma mark - ANTBaseTableViewControllerDelegate
- (void)pullNextPageRequest:(UITableView *)tableView {
    [MBProgressHUD showTip:@"亲、要记得经常清理缓存哦~"];
}

- (void)pullRefreshRequest:(UITableView *)tableView {
    [MBProgressHUD showTip:@"亲、要记得经常清理缓存哦~"];
    [self.memoryTimeTableVC loadDataFail];
}

- (MemeoryTimeTableViewController *)memoryTimeTableVC {
    if (!_memoryTimeTableVC) {
        _memoryTimeTableVC = [[MemeoryTimeTableViewController alloc] initWithStyle:UITableViewStylePlain];
        _memoryTimeTableVC.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _memoryTimeTableVC.delegate = (id)self;
        _memoryTimeTableVC.enableRefresh = YES;
        _memoryTimeTableVC.enableNextPage = YES;
    }
    return _memoryTimeTableVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
