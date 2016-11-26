//
//  CenterViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "CenterViewController.h"

static CGFloat headerHeight = 164;

@interface CenterViewController () <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

/** 表格*/
@property (nonatomic, weak) UITableView *tableView;
/** 背景 */
@property (nonatomic, strong) UIView *header;
/** 背景图片 */
@property (nonatomic, strong) UIImageView *pictureImageView;
/** 账号*/
@property(nonatomic, strong) UILabel *userNameLab;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"中心";
    [self buildView];
}

- (void)buildView {
    
    // table view
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.backgroundColor = kDefaultViewBackgroundColor;
    [self.contentView addSubview:tableView];
    
    // 添加头视图 在头视图上添加ImageView
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    _pictureImageView = [[UIImageView alloc] initWithFrame:_header.bounds];
    _pictureImageView.image = [UIImage imageNamed:@"lbg41009"];
    
    // 保持内容高宽比 缩放内容 超出视图的部分内容会被裁减 填充UIView
    _pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    // 这个属性决定了子视图的显示范围 取值为YES时，剪裁超出父视图范围的子视图部分.这里就是裁剪了_pictureImageView超出_header范围的部分.
    _pictureImageView.clipsToBounds = YES;
    [_header addSubview:_pictureImageView];
    self.tableView.tableHeaderView = _header;
    [self.view addSubview:_tableView];
    
    
    self.userNameLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, 100, 200, 50)];
    self.userNameLab.text = @"这是一款神奇的软件...";
    self.userNameLab.font = XiHeiFont(15);
    self.userNameLab.textAlignment = NSTextAlignmentCenter;
    self.userNameLab.textColor = [UIColor whiteColor];
    [self.header addSubview:self.userNameLab];
}

#pragma mark - 下拉放大头部视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = headerHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / headerHeight;
        CGFloat width = SCREEN_WIDTH;
        // 拉伸后图片位置
        _pictureImageView.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
    }
}

#pragma mark - tableView delegate And DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"register_m_selected"];
        cell.textLabel.text = @"男男";
    }
    else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"register_f_selected"];
        cell.textLabel.text = @"女女";
    }
    else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"setting-9"];
        cell.textLabel.text = @"相册";
    }
    else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"setting-2"];
        cell.textLabel.text = @"清理缓存";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"Setting-click"];
        cell.textLabel.text = @"设置";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:{
            NSString *path = kCachesPath;
            NSFileManager *fileManager=[NSFileManager defaultManager];
            float folderSize;
            if ([fileManager fileExistsAtPath:path]) {
                // 拿到所有文件的数组
                NSArray *childerFiles = [fileManager subpathsAtPath:path];
                // 拿到每个文件的名字,如有有不想清除的文件就在这里判断
                for (NSString *fileName in childerFiles) {
                    //将路径拼接到一起
                    NSString *fullPath = [path stringByAppendingPathComponent:fileName];
                    folderSize += [self fileSizeAtPath:fullPath];
                }
                
                [UIAlertController showAlertInViewController:self withTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?", folderSize] cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                    if (buttonIndex == controller.destructiveButtonIndex) {
                        //点击了确定,遍历整个caches文件,将里面的缓存清空
                        NSString *path = kCachesPath;
                        NSFileManager *fileManager=[NSFileManager defaultManager];
                        if ([fileManager fileExistsAtPath:path]) {
                            NSArray *childerFiles=[fileManager subpathsAtPath:path];
                            for (NSString *fileName in childerFiles) {
                                //如有需要，加入条件，过滤掉不想删除的文件
                                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                                [fileManager removeItemAtPath:absolutePath error:nil];
                            }
                        }
                    }
                }];
                
            }
        }
            
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
}

//计算单个文件夹的大小
- (float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
