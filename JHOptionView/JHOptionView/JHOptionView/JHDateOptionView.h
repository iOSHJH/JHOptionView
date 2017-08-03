//
//  JHDateOptionView.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHBaseOptionView.h"

@interface JHDateOptionView : JHBaseOptionView

/*
     设置允许最小日期、最大日期范围 正确姿势
 
    1、大范围用这种方式，大于 60年前或60年后
     NSString *minStr = @"1800-01-01";
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSDate *minDate = [dateFormatter dateFromString:minStr];
     _datePicker.minimumDate = minDate;
     _datePicker.maximumDate = [NSDate date];
     
    2、小范围可以用这种方式
     // 设置最小时间（20年前）
     _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-(40 * 365 * 24 * 60 * 60)];
     // 设置最大时间（20年后）
     _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(20 * 365 * 24 * 60 * 60)];
*/
/** 设置title、日期类型、最小时间、最大时间、选择哪一时*/
- (void)setTitle:(NSString *)title dateMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate selectDate:(NSDate *)date;

/** 选中的date*/
@property (nonatomic, strong) NSDate *selectDate;
/***  选中的生日 yyyy年MM月dd日*/
@property (nonatomic, copy) NSString *selectDate1;
/** yyyy-MM-dd*/
@property (nonatomic, copy) NSString *selectDate2;


@end
