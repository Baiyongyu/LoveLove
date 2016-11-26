//
//  ComBaseTableViewController.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "SRRefreshView.h"
#import "ComBaseTableViewController.h"

@interface ComBaseTableViewController ()
@property BOOL decelerateEnd;
@property (nonatomic,strong)SRRefreshView *slimeView;
@property (nonatomic,strong)ArrowView*  arrowUpView;
@property (nonatomic,strong)UILabel *tipLabel;
@end

@implementation ComBaseTableViewController
@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray=nil;
    self.pageNum=1;
    
    self.arrowUpView=[[ArrowView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH, 50)];
    self.arrowUpView.type=ArrowsType_Request;
    self.arrowUpView.hidden=YES;
    self.arrowUpView.state=ArrowsSate_Normal;
    [self.view addSubview:self.arrowUpView];
    [self.tableView addSubview:self.slimeView];
}

- (void)loadDataSuccess:(NSArray *)responseArray
{
    if (self.pageNum == 1)
    {
        self.dataArray = nil;
    }
    if (!responseArray.count) {
        self.totalPagesNum = self.pageNum;
    }
    NSMutableArray *dataArrray = [[NSMutableArray alloc] initWithArray:self.dataArray];
    [dataArrray addObjectsFromArray:responseArray];
    self.dataArray = dataArrray;
}

- (void)loadDataFail
{
    if (self.pageNum > 1)
    {
        self.pageNum--;
    }
    self.dataArray = self.dataArray;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate performSelector:@selector(tableView:didSelectRowAtIndexPath:) withObject:tableView withObject:indexPath];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate != (id)self && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
    {
        [self.delegate performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
    }
    
    if (self.enableRefresh)
    {
        [_slimeView scrollViewDidScroll];
    }
    if(self.enableNextPage)
    {
        float offsetMax=self.tableView.contentSize.height-self.tableView.frame.size.height;
        float offsetY=scrollView.contentOffset.y;
        
        if (self.pageNum>=self.totalPagesNum||offsetMax<0)
        {
            return;
        }
        
        self.arrowUpView.frame=CGRectMake(0,self.tableView.contentSize.height,SCREEN_WIDTH, 50);
        self.arrowUpView.hidden=NO;
        
        if (offsetMax>0 && offsetY>=offsetMax
            &&self.decelerateEnd
            &&self.arrowUpView.state!=ArrowsSate_Start)
        {
            self.decelerateEnd=NO;
            self.arrowUpView.state=ArrowsSate_Start;
            [UIView animateWithDuration:0.3 animations:^{
                self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
                scrollView.contentOffset=CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+50);
            }
                             completion:^(BOOL finished)
             {
                 if ([self.delegate respondsToSelector:@selector(pullNextPageRequest:)])
                 {
                     [self.delegate pullNextPageRequest:self.tableView];
                 }
                 
             }];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.decelerateEnd=YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.enableRefresh)
    {
        [_slimeView scrollViewDidEndDraging];
    }
}

#pragma mark - slimeRefresh delegate
//刷新列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    if ([self.delegate respondsToSelector:@selector(pullRefreshRequest:)])
    {
        [self.delegate pullRefreshRequest:self.tableView];
    }
}

#pragma mark - getters and setters
- (void)setDataArray:(NSMutableArray *)array
{
    dataArray = array;
    [self.tableView reloadData];
    
    if (self.arrowUpView.state==ArrowsSate_Start)
    {
        self.arrowUpView.state=ArrowsSate_End;
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentInset = UIEdgeInsetsZero;
        }completion:^(BOOL finished)
        {
            self.arrowUpView.hidden=YES;
        }];
        WS(weakSelf);
        [weakSelf performBlock:^{
            weakSelf.arrowUpView.state=ArrowsSate_Normal;
            weakSelf.decelerateEnd=YES;
        } afterDelay:0.3];
    }
    else
    {
        self.arrowUpView.hidden=YES;
        [self.slimeView endRefresh];
    }
    
    if (self.noDataTip.length) {
        if (!array.count) {
            if (!self.tipLabel.superview) {
                [self.view insertSubview:self.tipLabel belowSubview:self.view];
                WS(weakSelf);
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(weakSelf.view);
                    make.width.mas_greaterThanOrEqualTo(200);
                    make.height.mas_greaterThanOrEqualTo(40);
                }];
                self.tipLabel.text = self.noDataTip;
            }
        } else if (self.tipLabel.superview) {
            [self.tipLabel removeFromSuperview];
        }
    }
}

- (SRRefreshView *)slimeView
{
    if (_slimeView == nil) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = (id)self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
    }
    
    return _slimeView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = XiHeiFont(16);
        _tipLabel.textColor = kLightGrayColor;
    }
    return _tipLabel;
}

@end

@interface ArrowView ()
@property UIImageView *arrowImgView;
@property UILabel* tipLabel;
@property UIActivityIndicatorView* actIndicator;
@end

@implementation ArrowView
@synthesize text,state;

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.arrowImgView=[[UIImageView alloc] initWithFrame:CGRectZero];
        self.arrowImgView.image = [UIImage imageNamed:@"refresh_arrow.png"];
        
        self.tipLabel=[self UILabelWithText:text fontSize:14];
        self.tipLabel.textColor=[UIColor darkGrayColor];
        self.tipLabel.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
        self.tipLabel.textAlignment=NSTextAlignmentCenter;
        self.actIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.actIndicator.frame=CGRectMake(0, 0, 30, 30);
        self.actIndicator.hidden=YES;
        [self addSubview:self.actIndicator];
        [self addSubview:self.tipLabel];
        [self addSubview:self.arrowImgView];
    }
    return self;
}

-(UILabel*)UILabelWithText:(NSString*)string fontSize:(int)fontSize
{
    CGSize size=[string sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]}];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.text=string;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];
    return label;
}

-(void)setText:(NSString *)value
{
    text=[value copy];
    self.tipLabel.text=text;
}

-(void)updateUI
{
    switch (state)
    {
        case ArrowsSate_Normal:
        {
            [UIView animateWithDuration:0.3 animations:^{
                CGFloat angle=(self.type==ArrowsType_Refresh)?M_PI*2:M_PI;
                self.arrowImgView.transform=CGAffineTransformMakeRotation(angle);
                self.arrowImgView.hidden=NO;
                self.text=(self.type==ArrowsType_Refresh)?@"下拉刷新":@"上拉加载下一页";
            }];
        }
            break;
        case ArrowsSate_Start:
        {
            self.arrowImgView.hidden=YES;
            self.text=@"正在载入...";
        }
            break;
        case ArrowsSate_Ready:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.arrowImgView.transform=CGAffineTransformMakeRotation(M_PI);
                self.arrowImgView.hidden=NO;
                self.text=@"松手刷新";
            }];
        }
            break;
        case ArrowsSate_End:
        {
            self.arrowImgView.hidden=YES;
            self.actIndicator.hidden=YES;
            self.text=@"加载结束";
        }
            break;
        case ArrowsSate_LastPage:
        {
            self.arrowImgView.hidden=YES;
            self.actIndicator.hidden=YES;
            self.text=@"没有更多了";
            NSLog(@"ArrowsSate_LastPage");
        }
            break;
            
        default:
            break;
    }
    
    if(self.delegate!=nil)
    {
        [self.delegate arrowView:self state:state];
    }
    
    CGSize size=[QMUtil getSizeWithText:self.text fontSize:14];
    self.arrowImgView.frame=CGRectMake((self.frame.size.width-(size.width+50.0))/2.0,(self.frame.size.height-30)/2.0, 22, 30);
    self.actIndicator.frame=self.arrowImgView.frame;
    
    if (ArrowsSate_End!=state)
    {
        self.actIndicator.hidden=!self.arrowImgView.hidden;
    }
    if (ArrowsSate_LastPage==state) {
        self.actIndicator.hidden = YES;
    }
    if (self.actIndicator.hidden)
    {
        [self.actIndicator stopAnimating];
    }
    else
    {
        [self.actIndicator startAnimating];
    }
    
}

-(void)setState:(ArrowsSate)value
{
    state=value;
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
    
}
@end
