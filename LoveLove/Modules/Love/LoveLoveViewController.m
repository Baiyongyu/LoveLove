//
//  LoveLoveViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "LoveLoveViewController.h"

@interface LoveLoveViewController ()
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation LoveLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kNavColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 20, 80, 40)];
    _titleLabel.text = @"爱爱";
    _titleLabel.font = XiHeiFont(18);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
