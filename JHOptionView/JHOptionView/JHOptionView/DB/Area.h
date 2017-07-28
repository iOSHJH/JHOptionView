//
//  Area.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "position" : "tr_0 tr_440000",
 "sort" : 5,
 "id" : 440100,
 "level" : 2,
 "area_name" : "广州市",
 "short_name" : "广州",
 "lng" : "113.28064",
 "lat" : "23.125177",
 "pid" : 440000
 }
 */

@interface Area : NSObject

/** 地区id*/
@property (nonatomic, copy) NSString *id;
/** 地区名*/
@property (nonatomic, copy) NSString *area_name;
/** 当前地区的上级地区id*/
@property (nonatomic, copy) NSString *pid;
/** 地区名 简称*/
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *sort;

@end
