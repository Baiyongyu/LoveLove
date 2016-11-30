//
//  PersonCenterViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "PersonCenterViewController.h"
/** Nav */
#import "NavHeadTitleView.h"
#import "HeadImageView.h"

/** 蜘蛛网图 */
#import "SXFiveScoreCell.h"
#import "SXAnimateVIew.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CircleFriendsTableViewCell.h"

#import "PhotoAlbumViewController.h"

#define kTimeLineTableViewCellId @"CircleFriendsTableViewCell"

@interface PersonCenterViewController () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NavHeadTitleViewDelegate>
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
}
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
/** 头部 */
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property(nonatomic,strong)NavHeadTitleView *NavView;//导航栏
@property(nonatomic,strong)HeadImageView *headImageView;//头视图
@property(nonatomic,assign)int rowHeight;
/** 表格 */
@property(nonatomic,strong) UITableView *tableView;
/** 蜘蛛网视图 */
@property(nonatomic,strong)SXAnimateVIew *animateView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kDefaultViewBackgroundColor;
    
    // 拉伸顶部图片
    [self lashenBgView];
    // 创建导航栏
    [self createNav];
    // 创建TableView
    [self createTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.5 animations:^{
        self.animateView.transform = CGAffineTransformIdentity;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SXFiveScoreCell *cell = [SXFiveScoreCell cell];
        
        cell.scores = self.scores;
//        cell.compareScores = self.compareScores;
//        cell.labelNames = self.labelNames;
        self.animateView = cell.scoreView;
        
        return cell;
    }
    
    static NSString *ID = @"cell";
    CircleFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CircleFriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.photoTapBlock = ^{
        PhotoAlbumViewController *photoVC = [[PhotoAlbumViewController alloc] init];
        photoVC.titles = @"夏茉";
        [self.navigationController pushViewController:photoVC animated:YES];
    };
    
    cell.iconView.image = [UIImage imageNamed:@"liu1.jpg"];
    cell.nameLable.text = @"夏茉";
    cell.contentLabel.text = @"刘飞儿，女，2007年第四十七届国际小姐中国冠军、中华慈善总会授予“爱心使者”称号；香港中华环境保护志愿者协会“环保公益事业形象大使”。";
    
    NSArray *picImageNamesArray = @[ @"xiamo1.jpg",@"xiamo2.jpg",@"xiamo3.jpg",@"xiamo4.jpg",@"xiamo5.jpg",@"xiamo6.jpg",@"xiamo7.jpg",@"xiamo8.jpg",@"xiamo9.jpg"];
    cell.picContainerView.picPathStringsArray = picImageNamesArray;
    
    // 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
//    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    return 420;
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
//    id model = self.dataArray[indexPath.row];
//    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CircleFriendsTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark - 导航栏渐变效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (contentOffsety <= 170) {
        self.NavView.headBgView.alpha = contentOffsety/170;
//        self.NavView.rightImageView = @"Setting";
        self.NavView.leftImageView = @"ic_black";
        self.NavView.color = [UIColor whiteColor];
    }else {
        self.NavView.headBgView.alpha = 1;
        self.NavView.headBgView.backgroundColor = kNavColor;
//        self.NavView.rightImageView = @"Setting-click";
        self.NavView.leftImageView = @"btn_back_white";
        self.NavView.color = [UIColor whiteColor];
    }
    if (contentOffsety < 0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight - contentOffsety;
        rect.size.width = _backImgWidth * (_backImgHeight - contentOffsety)/_backImgHeight;
        rect.origin.x = -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
    }
}

- (void)NavHeadToLeft {
    [self.navigationController popViewControllerAnimated:YES];
}
// 头像点击事件
- (void)tapClick:(UITapGestureRecognizer *)recognizer {
    NSLog(@"修改头像");
}

#pragma mark - 拉伸顶部图片
- (void)lashenBgView {
    
    _backgroundImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [_backgroundImgV sd_setImageWithURL:[NSURL URLWithString:@"http://img.zngirls.com/gallery/21337/17758/003.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _backgroundImgV.userInteractionEnabled = YES;
    _backImgHeight = _backgroundImgV.frame.size.height;
    _backImgWidth = _backgroundImgV.frame.size.width;
    _backImgOrgy = _backgroundImgV.frame.origin.y;
    [self.view addSubview:_backgroundImgV];
}

#pragma mark - 创建TableView
- (void)createTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    _tableView.tableHeaderView = self.headerView;
}

#pragma mark - 头视图
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 180)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        // 头像
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) - 40, 100, 100)];
        _headerImg.center = CGPointMake(SCREEN_WIDTH/2, 100);
        [_headerImg setImage:[UIImage imageNamed:@"xiamo10.jpg"]];
        _headerImg.contentMode = UIViewContentModeScaleToFill;
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:2.0f];
        [_headerImg.layer setBorderWidth:2.0f];
        [_headerImg.layer setBorderColor:[UIColor whiteColor].CGColor];
        _headerImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_headerImg addGestureRecognizer:tap];
        [_headerView addSubview:_headerImg];
        // 签名
        _nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(147, CGRectGetMaxY(_headerImg.frame) + 20, SCREEN_WIDTH - 20, 20)];
        _nickLabel.center = CGPointMake(SCREEN_WIDTH/2, 160);
        _nickLabel.text = @"◆◇、嗯哼嗯哼、摩擦擦...";
        _nickLabel.textColor = kDarkGrayColor;
        _nickLabel.font = XiHeiFont(14);
        _nickLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_nickLabel];
    }
    return _headerView;
}

#pragma mark - 创建导航栏
- (void)createNav {
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.NavView.title = @"资料详情";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.leftImageView = @"ic_black";
    //    self.NavView.rightTitleImage = @"Setting";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
