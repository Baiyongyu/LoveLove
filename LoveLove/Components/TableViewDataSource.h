//
//  TableViewDataSource.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/12/06.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface TableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSMutableArray *)items CellIdentifier:(NSString *)cellIdentifier ConfigureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
