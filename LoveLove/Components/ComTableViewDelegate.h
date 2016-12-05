//
//  ComTableViewDelegate.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/29.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ComTableViewDelegate : NSObject <UITableViewDataSource,UITableViewDelegate>
{
    void(^indexRowClick)(NSIndexPath *indexpath);
    UITableView *tabView;
    NSString *cellIdentifierName;
}

@property (nonatomic, strong) id dataArray;

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
                  click:(void(^)(NSIndexPath *indexpath))rowClick;

@end

