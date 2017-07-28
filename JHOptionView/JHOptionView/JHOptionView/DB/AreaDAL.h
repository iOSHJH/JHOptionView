//
//  AreaDAL.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface AreaDAL : NSObject

@property(nonatomic,strong) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedInstance;

/** 获取所有的地区，包括 省市县*/
- (void)getAllTAreasFinished:(void(^)(NSArray *areas, NSError *error))finished;

@end
