//
//  ComTableViewDelegate.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComTableViewDelegate.h"

@implementation ComTableViewDelegate

/**
 *  初始化tableView
 *
 *  @param tableView          需要显示的tableView
 *  @param cellIdentifier     cellIdentifier
 *  @param useXib             是否使用xib
 *  @param data               数据
 *  @param rowClick           点击每一行的事件
 */
- (instancetype)initWithTableView:(UITableView *)tableView
         cellIdentifier:(NSString *)cellIdentifier
                 useXib:(BOOL)useXib
                   data:(id)data
                  click:(void(^)(NSIndexPath *indexpath))rowClick {
    
    if (self = [super init]) {
        tabView = tableView;
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 40;
        tabView.tableFooterView = [[UITableView alloc] initWithFrame:CGRectZero];
       
        tabView.delegate = self;
        tabView.dataSource = self;
        
        if (rowClick) {
            indexRowClick = rowClick;
        }
        
        if (data) {
            _dataArray = data;
        }
            cellIdentifierName = cellIdentifier;
        
        if (useXib) {
            [tabView registerNib:[UINib nibWithNibName:cellIdentifierName bundle:nil] forCellReuseIdentifier:cellIdentifierName];
        }
    }
    
    return self;
}

#pragma mark - TableView Deldegate And DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierName forIndexPath:indexPath];
    [cell setValue:self.dataArray[indexPath.row] forKey:@"data"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    indexRowClick(indexPath);
}

// 重写set方法，更换数据
- (void)setDataArr:(id)dataArray {
    _dataArray = dataArray;
    [tabView reloadData];
}

@end
