//
//  ComBaseViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComBaseViewController.h"

@interface ComBaseViewController ()
@property CGPoint activePoint;
@property(nonatomic,strong)UIScrollView *handelKeyboardScrollView;
@end

@implementation ComBaseViewController

#pragma mark - life style
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImgView.image = [UIImage imageNamed:@"home_bkg_8_320x600_"];
    [self.view addSubview:bgImgView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kDefaultViewBackgroundColor;
    [self loadSubViews];
    [self layoutConstraints];
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadSubViews
{
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navBar];
    [self.navBar addSubview:self.leftBtn];
    [self.navBar addSubview:self.rightBtn];
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    [self.navBar addSubview:self.titleLabel];
    [self layoutNavigationBar];
}

- (void)layoutNavigationBar
{
    WS(weakSelf);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.navBar).offset(0);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.navBar).offset(-10);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right).offset(5);
        make.right.mas_equalTo(weakSelf.rightBtn.mas_left).offset(-5);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.view setNeedsLayout];
}

- (void)layoutConstraints
{
    
}

- (void)loadData
{
    
}

- (void)handleKeyboardShowEvent
{
    self.contentView.scrollEnabled = YES;
    self.contentView.contentSize = self.contentView.frame.size;
    [self handleKeyboardShowEventForScrollView:self.contentView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.contentView addGestureRecognizer:tapGesture];
}

- (void)handleKeyboardShowEventForScrollView:(UIScrollView *)scrollView
{
    self.handelKeyboardScrollView = scrollView;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(textBeginEditing:)
                                                name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(textBeginEditing:)
                                                name:UITextViewTextDidBeginEditingNotification object:nil];
}

#pragma mark - actions
- (void)leftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction
{
    
}

- (void)tapAction
{
    [self.view endEditing:YES];
}

- (void)textBeginEditing:(NSNotification*)aNotification
{
    UIView* sender=[aNotification object];
    CGRect rect=sender.frame;
    rect.origin.y+=rect.size.height;
    self.activePoint=[[sender superview] convertPoint:rect.origin toView:self.handelKeyboardScrollView];
    self.activePoint=[self.handelKeyboardScrollView convertPoint:self.activePoint toView:self.handelKeyboardScrollView];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    kbSize.height+=30;
    
    float hiddenH = kbSize.height;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,hiddenH, 0.0);
    self.handelKeyboardScrollView.contentInset = contentInsets;
    self.handelKeyboardScrollView.scrollIndicatorInsets = contentInsets;
    float activeH=self.handelKeyboardScrollView.frame.size.height-self.activePoint.y;
    if(kbSize.height>activeH)
    {
        float dif=activeH-kbSize.height;
        CGPoint scrollPoint = CGPointMake(0.0,0-dif);
        [self.handelKeyboardScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.handelKeyboardScrollView.contentInset = contentInsets;
        self.handelKeyboardScrollView.scrollIndicatorInsets = contentInsets;
    }];
}

#pragma mark - getters and setters
- (UIView *)navBar
{
    if (!_navBar) {
        _navBar= [[UIView alloc] init];
        _navBar.backgroundColor = kNavColor;
    }
    return _navBar;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = XiHeiFont(14);
        [_leftBtn setContentMode:UIViewContentModeCenter];
        _leftBtn.imageView.layer.masksToBounds = YES;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = XiHeiFont(14);
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_rightBtn setContentMode:UIViewContentModeCenter];
    }
    return _rightBtn;
}

- (UIView *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] init];
        _titleLabel.font = XiHeiFont(18);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.scrollEnabled = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.scrollsToTop = NO;
    }
    return _contentView;
}

@end
