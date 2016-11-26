//
//  FMDBManagers.m
//  LoveLove
//
//  Created by 宇玄丶 on 2016/11/25.
//  Copyright © 2016年 宇玄丶. All rights reserved.
//

#import "FMDBManagers.h"
#import "FMDB.h"

@interface FMDBManagers ()

@end

@implementation FMDBManagers

+ (NSArray *)getAllModel:(NSString *)table {
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"Model" ofType:@"db"];
    NSLog(@"%@",dbPath);
    
    FMDatabase* dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (![dataBase open]) {
        return nil;
    }
    FMResultSet *rs = [dataBase executeQuery:[NSString stringWithFormat:@"select * from %@",table]];
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    while ([rs next]) {
        AppModel *model = [[AppModel alloc] init];
        model.name = [rs stringForColumn:@"name"];
        model.image = [rs stringForColumn:@"image"];
        [modelArray addObject:model];
    }
    [dataBase close];
    
    return modelArray;
}

@end
