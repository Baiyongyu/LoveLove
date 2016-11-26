//
//  MyLoveViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "MyLoveViewController.h"
#import "FMDBManagers.h"
#import "AppModel.h"
#define cellHeight 250

@interface MyLoveViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation MyLoveViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"My Love";
    self.leftBtn.hidden = NO;
}

- (void)layoutConstraints {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = kDefaultViewBackgroundColor;
    [self.contentView addSubview:_tableView];

}

- (void)loadData {
    NSArray *array = [FMDBManagers getAllModel:[NSString stringWithFormat:@"xiamo%d",self.index]];
    for (AppModel *model in array) {
        [self.dataSource addObject:model];
//        NSLog(@"%@",self.dataSource);
        NSLog(@"%@",model.image);
    }
}

#pragma mark ---------tableView-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    return cell;
}

// 在willDisplayCell里面处理数据能优化tableview的滑动流畅性
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell * myCell = (MyCell *)cell;
    
    myCell.appModel = self.dataSource[indexPath.row];
    [myCell cellOffset];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // visibleCells 获取界面上能显示出来了cell
    NSArray<MyCell *> *array = [self.tableView visibleCells];
    
    //enumerateObjectsUsingBlock 类似于for，但是比for更快
    [array enumerateObjectsUsingBlock:^(MyCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj cellOffset];
    }];
}


- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //取消选中效果
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        //裁剪看不到的
        self.clipsToBounds = YES;
        
        //pictureView的Y往上加一半cellHeight 高度为2 * cellHeight，这样上下多出一半的cellHeight
        _pictureView = ({
            UIImageView * picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, -cellHeight/2, SCREEN_WIDTH, cellHeight * 2)];
            picture.contentMode = UIViewContentModeScaleAspectFill;
            picture;
        });
        [self.contentView  addSubview:_pictureView];
        
        _coverview = ({
            UIView * coverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellHeight)];
            coverview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
            coverview;
        });
//        [self.contentView addSubview:_coverview];
        
        _titleLabel = ({
            UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellHeight / 2 - 30, SCREEN_WIDTH, 30)];
            titleLabel.font = [UIFont boldSystemFontOfSize:16];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.text = @"Love Love";
            titleLabel;
        });
        [self.contentView addSubview:_titleLabel];
        
        _littleLabel = ({
            UILabel * littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellHeight / 2 + 30, SCREEN_WIDTH, 30)];
            littleLabel.font = [UIFont systemFontOfSize:14];
            littleLabel.textAlignment = NSTextAlignmentCenter;
            littleLabel.textColor = [UIColor whiteColor];
            littleLabel.text = @"116";
            littleLabel;
        });
        [self.contentView addSubview:_littleLabel];
    }
    return self;
}

- (CGFloat)cellOffset {
    /*
     - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
     将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     这里用来获取self在window上的位置
     */
    CGRect toWindow = [self convertRect:self.bounds toView:self.window];
    
    //获取父视图的中心
    CGPoint windowCenter = self.superview.center;
    
    //cell在y轴上的位移  CGRectGetMidY之前讲过,获取中心Y值
    CGFloat cellOffsetY = CGRectGetMidY(toWindow) - windowCenter.y;
    
    //位移比例
    CGFloat offsetDig = 2 * cellOffsetY / self.superview.frame.size.height ;
    
    //要补偿的位移
    CGFloat offset =  -offsetDig * cellHeight/2;
    
    //让pictureViewY轴方向位移offset
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    self.pictureView.transform = transY;
    
    return offset;
}

- (void)setAppModel:(AppModel *)appModel {
    _appModel = appModel;
//    [self.pictureView setImageWithURLString:appModel.image placeholderImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:appModel.image] placeholderImage:[UIImage imageNamed:@"zhanweitu.jpg"]];
}

@end




