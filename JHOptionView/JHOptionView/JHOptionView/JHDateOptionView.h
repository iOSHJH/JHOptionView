//
//  JHDateOptionView.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHBaseOptionView.h"

@interface JHDateOptionView : JHBaseOptionView

/** 设置title、日期模式、选择哪一时*/
- (void)setTitle:(NSString *)title dateMode:(UIDatePickerMode)mode selectDate:(NSDate *)date;

/** 选中的date*/
@property (nonatomic, strong) NSDate *selectDate;
/***  选中的生日 yyyy年MM月dd日*/
@property (nonatomic, copy) NSString *selectDate1;
/** yyyy-MM-dd*/
@property (nonatomic, copy) NSString *selectDate2;


@end
