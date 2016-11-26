//
//  MemeoryTimeTableViewController.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/26.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import "ComBaseTableViewController.h"
#import "MemoryTimeModel.h"

@interface MemeoryTimeTableViewController : ComBaseTableViewController
@end

@interface MemoryTimeCell : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,retain)MemoryTimeModel *happyData;
@end
