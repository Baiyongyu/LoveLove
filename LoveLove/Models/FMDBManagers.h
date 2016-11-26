//
//  FMDBManagers.h
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppModel.h"

@interface FMDBManagers : NSObject
+ (NSArray *)getAllModel:(NSString *)table;
@end
