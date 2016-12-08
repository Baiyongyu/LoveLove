//
//  HomeViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "HomeViewController.h"

#import "PhotoAlbumViewController.h"
#import "MemeoryTimeTableViewController.h"  // 岁月
#import "HomeHeaderBannerView.h"
#import "HomeHeaderCardView.h"
#import "PersonCenterViewController.h"     // 个人资料详情
#import "ComWebViewController.h"
@interface HomeViewController () <UIScrollViewDelegate,DidSeletedViewItemDelegate>

@property (nonatomic, strong) UIView *headerBgView;
@property (nonatomic, strong) MemeoryTimeTableViewController *memoryTimeTableVC;
@property (nonatomic, strong) HomeHeaderBannerView *headerBannerView;
@property (nonatomic, strong) HomeHeaderCardView *headerCardView;
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
    [self.headerBgView addSubview:self.headerBannerView];
    [self.headerBgView addSubview:self.headerCardView];
}

- (void)layoutConstraints {

    /** MemoryTimeTableVC */
    WS(weakSelf);
    [self.memoryTimeTableVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    self.memoryTimeTableVC.tableView.tableHeaderView = self.headerBgView;
    
    /** 回到顶部 */
    ToViewTopButton *topButton = [[ToViewTopButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - kNavbarHeight - kTabBarHeight, 40, 40) scrollView:(UIScrollView *)self.memoryTimeTableVC.view];
    topButton.showBtnOffset = 350;
    [self.view addSubview:topButton];
}
#pragma mark - 首页热门推荐item 代理
- (void)didSeletedViewItem:(NSIndexPath *)indexPath {
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
    // 传5个属性值
    personVC.scores = @[@(4.6),@(4.7),@(4.5),@(4.8),@(4.8)];
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


- (void)loadData {
    
    MemoryTimeModel *activityData7 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData7 ActivityTime:@"1986-01-08" activityName:@"小泽玛利亚" activityDetailInfo:@"小泽玛利亚（日语：小泽マリア、おざわ まりあ，英语：Ozawa Maria），1986年1月8日出生于日本北海道，混血儿（父亲是法裔加拿大人，母亲是日本人），日本AV女优。"];
    
    MemoryTimeModel *activityData6 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData6 ActivityTime:@"1992-6-" activityName:@"泷泽萝拉" activityDetailInfo:@"水咲萝拉（水咲ローラ），原名泷泽萝拉，1992年6月出生于日本东京，日本女演员、AV女优。"];
    
    MemoryTimeModel *activityData5 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData5 ActivityTime:@"1991-11-30" activityName:@"爱沢有纱" activityDetailInfo:@"爱泽有沙（Aizawa Arisa），1991年11月30日出生于日本神奈川县，av女优。"];
    
    MemoryTimeModel *activityData4 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData4 ActivityTime:@"1972-10-31" activityName:@"饭岛爱" activityDetailInfo:@"饭岛爱，日本女演员、前AV电影女优，1972年10月31日出生于东京都 江东区龟户。"];
    
    MemoryTimeModel *activityData3 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData3 ActivityTime:@"1989-3-2" activityName:@"亚里沙" activityDetailInfo:@"1989年3月2日,日本福冈县出身的写真偶像、女演员。2011年3月于青山学院大学毕业，于IT企业就职。"];
    
    MemoryTimeModel *activityData2 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData2 ActivityTime:@"1988-05-24" activityName:@"波多野结衣" activityDetailInfo:@"1988年5月24日出生于日本京都府，著名日本女演员、AV女优。2008年，波多野结衣开始从事AV出演。2014年，她获得“年度最佳AV女优”奖。"];
    
    MemoryTimeModel *activityData1 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData1 ActivityTime:@"1983-11-11" activityName:@"苍井空" activityDetailInfo:@"1983年11月11日出生于日本东京。日本AV女演员、成人模特，兼电视、电影演员。日本女子组合惠比寿麝香葡萄的初代首领，现成员、OG首领。其后进入AV界发展。"];

    MemoryTimeModel *activityData0 = [[MemoryTimeModel alloc] init];
    [self loadActivityData:activityData0 ActivityTime:@"1993-03-14" activityName:@"刘飞儿" activityDetailInfo:@"2007年第四十七届国际小姐中国冠军、中华慈善总会授予“爱心使者”称号；香港中华环境保护志愿者协会“环保公益事业形象大使”。"];
    
    self.memoryTimeTableVC.dataArray = [@[activityData0, activityData1, activityData2, activityData3, activityData4, activityData5, activityData6, activityData7] mutableCopy];
}

#pragma mark - 首页加载幸福时光数据封装
- (void)loadActivityData:(MemoryTimeModel *)happyData ActivityTime:(NSString *)activityTime activityName:(NSString *)activityName activityDetailInfo:(NSString *)activityDetailInfo {
    
    happyData.time = activityTime;
    happyData.titleName = activityName;
    happyData.detailInfo = activityDetailInfo;
    
    // 布局计算
    CGFloat height = 85;
    CGSize activityDetailSize = [QMUtil sizeWithString:happyData.detailInfo font:XiHeiFont(16) size:CGSizeMake(SCREEN_WIDTH-100, 80)];
    height += activityDetailSize.height;

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

- (UIView *)headerBgView {
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 140 + 88 + 300)];
        _headerBgView.backgroundColor = [UIColor clearColor];
    }
    return _headerBgView;
}

- (HomeHeaderBannerView *)headerBannerView {
    if (!_headerBannerView) {
        _headerBannerView = [[HomeHeaderBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160 + 88)];
        _headerBannerView.backgroundColor = [UIColor clearColor];
    }
    return _headerBannerView;
}

- (HomeHeaderCardView *)headerCardView {
    if (!_headerCardView) {
        _headerCardView = [[HomeHeaderCardView alloc] initWithFrame:CGRectMake(0, 140 + 88, SCREEN_WIDTH, 300)];
        _headerCardView.backgroundColor = [UIColor clearColor];
        _headerCardView.delegate = self;
    }
    return _headerCardView;
}

#pragma mark - TimeVC
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
