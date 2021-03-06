//
//  MemeoryTimeTableViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "MemeoryTimeTableViewController.h"

//#import "WaterLayoutViewController.h"
#import "PersonCenterViewController.h"
@interface MemeoryTimeTableViewController () <BaseTableViewControllerDelegate>

@end

@implementation MemeoryTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = kDefaultViewBackgroundColor;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 15, SCREEN_WIDTH - 80, headerView.height)];
    imgView.image = [UIImage imageNamed:@"guide_male_title"];
    imgView.center = CGPointMake(SCREEN_WIDTH/2, 28);
    imgView.contentMode = UIViewContentModeScaleToFill;
    [headerView addSubview:imgView];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"activityCell";
    MemoryTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MemoryTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.index = indexPath.row;
    cell.happyData = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoryTimeModel *activityData = self.dataArray[indexPath.row];
    return activityData.contentHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
    personVC.scores = @[@(4.6),@(4.7),@(4.5),@(4.8),@(4.8)];
    [kRootNavigation pushViewController:personVC animated:YES];
}

#pragma mark - 取消heightForHeaderInSection 悬浮
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat sectionHeaderHeight = 60;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(- sectionHeaderHeight, 0, 0, 0);
//    }
//}

@end

@interface MemoryTimeCell ()
//时间
@property(nonatomic,strong)UILabel *timeLabel;
//编号
@property(nonatomic,strong)UILabel *numberLabel;
//背景
@property(nonatomic,strong)UIImageView *bgView;
//竖线
@property(nonatomic,strong)UIImageView *lineImageView;
//圆球
@property(nonatomic,strong)UIImageView *roundImageView;
//名称
@property(nonatomic,strong)UILabel *activityNameLabel;
//详细信息
@property(nonatomic,strong)UILabel *detailInfoLabel;
//图片
@property(nonatomic,strong)UIImageView *photo;
@end

@implementation MemoryTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.lineImageView];
        [self.contentView addSubview:self.roundImageView];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.activityNameLabel];
        [self.bgView addSubview:self.detailInfoLabel];
        [self.bgView addSubview:self.photo];
        [self layoutConstraints];
    }
    return self;
}

- (void)layoutConstraints {
    WS(weakSelf);
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(50);
        make.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(15);
        make.width.mas_greaterThanOrEqualTo(120);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(4);
        make.top.bottom.equalTo(weakSelf.contentView);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.lineImageView);
        make.width.height.mas_equalTo(15);
        make.top.equalTo(weakSelf.contentView);
    }];
    self.numberLabel.layer.cornerRadius = 7.5;
    
    [self.roundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.lineImageView);
        make.top.mas_equalTo(weakSelf.numberLabel.mas_bottom).offset(22);
        make.width.height.mas_equalTo(10);
    }];
    self.roundImageView.layer.cornerRadius = 5;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.timeLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.lineImageView.mas_right).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView).offset(-15);
    }];
    
    [self.activityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgView).offset(21);
        make.right.equalTo(weakSelf.bgView).offset(-15);
        make.top.equalTo(weakSelf.bgView).offset(10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.activityNameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(weakSelf.bgView).offset(21);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.detailInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.photo.mas_right).offset(10);
        make.right.equalTo(weakSelf.bgView).offset(-10);
        make.top.mas_equalTo(weakSelf.activityNameLabel.mas_bottom).offset(5);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
}

#pragma mark - getters and setters

- (void)setHappyData:(MemoryTimeModel *)happyData {
    _happyData = happyData;
    self.timeLabel.text = _happyData.time;
    self.activityNameLabel.text = _happyData.titleName;
    self.detailInfoLabel.text = _happyData.detailInfo;
    [self.photo sd_setImageWithURL:[NSURL URLWithString:_happyData.imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",index+1];
    UIColor *color;
    if (index%4==0) {
        color = [UIColor hexStringToColor:@"#FDD530"];
    } else if (index%4==1) {
        color = [UIColor hexStringToColor:@"#ee6f89"];
    } else if (index%4==2) {
        color = [UIColor hexStringToColor:@"#0078bb"];
    } else if (index%4==3) {
        color = [UIColor hexStringToColor:@"#46bbd5"];
    }
    self.numberLabel.backgroundColor = color;
    self.roundImageView.backgroundColor = color;
    self.lineImageView.backgroundColor = color;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = XiHeiFont(16);
    }
    return _timeLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = XiHeiFont(10);
        _numberLabel.clipsToBounds = YES;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
    }
    return _numberLabel;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [[UIImage imageNamed:@"ic_dialog"] stretchableImageWithLeftCapWidth:15 topCapHeight:24];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = kBgLightGrayColor;
    }
    return _lineImageView;
}

- (UIImageView *)roundImageView {
    if (!_roundImageView) {
        _roundImageView = [[UIImageView alloc] init];
        _roundImageView.backgroundColor = kGreenColor;
        _roundImageView.layer.masksToBounds = YES;
    }
    return _roundImageView;
}

- (UILabel *)activityNameLabel {
    if (!_activityNameLabel) {
        _activityNameLabel = [[UILabel alloc] init];
        _activityNameLabel.font = XiHeiFont(16);
        _activityNameLabel.numberOfLines = 0;
    }
    return _activityNameLabel;
}

- (UIImageView *)photo {
    if (!_photo) {
        _photo = [[UIImageView alloc] init];
        _photo.layer.masksToBounds = YES;
        _photo.contentMode = UIViewContentModeScaleToFill;
        _photo.userInteractionEnabled = YES;
    }
    return _photo;
}

- (UILabel *)detailInfoLabel {
    if (!_detailInfoLabel) {
        _detailInfoLabel = [[UILabel alloc] init];
        _detailInfoLabel.font = XiHeiFont(16);
        _detailInfoLabel.textColor = kDarkGrayColor;
        _detailInfoLabel.numberOfLines = 3;
        _detailInfoLabel.userInteractionEnabled = YES;
    }
    return _detailInfoLabel;
}

@end
