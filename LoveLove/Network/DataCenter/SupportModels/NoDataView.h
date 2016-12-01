//
//  NoDataView.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/30.
//  Copyright © 2016年 北京116科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReloadNewDataBlock)();

@interface NoDataView : UIView

@property (nonatomic,copy) ReloadNewDataBlock reloadNewDataBlock;

@end
