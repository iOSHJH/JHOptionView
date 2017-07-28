//
//  AreaDAL.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "AreaDAL.h"
#import "Area.h"
#import "YYModel.h"

@implementation AreaDAL

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ht_area" ofType:@"sqlite"];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

#pragma mark - 表 t_area

/** 获取所有的地区，包括 省市县*/
- (void)getAllTAreasFinished:(void(^)(NSArray *areas, NSError *error))finished {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_area"];
    NSMutableArray *array = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        
        if (!result) {
            NSLog(@"DAL：获取所有的地区 查询失败");
            NSError *error = [NSError errorWithDomain:@"AreaDAL" code:-1001 userInfo:@{@"AreaDAL": @"DAL：获取所有的地区 查询失败"}];
            finished(nil, error);
            return;
        }
        while ([result next]) {
            NSDictionary *dict = [result resultDictionary];
            Area *area = [Area yy_modelWithDictionary:dict];
            [array addObject:area];
        }
        finished(array, nil);
    }];
}

@end
