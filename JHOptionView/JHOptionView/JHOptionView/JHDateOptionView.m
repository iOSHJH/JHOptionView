//
//  JHDateOptionView.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHDateOptionView.h"

@interface JHDateOptionView ()

@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation JHDateOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.containView);
            make.top.equalTo(self.headView.mas_bottom);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.width.equalTo(self.containView.mas_width);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title dateMode:(UIDatePickerMode)mode minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate selectDate:(NSDate *)date {
    self.titleLabel.text = title;
    self.datePicker.datePickerMode = mode;
    self.datePicker.minimumDate = minimumDate;
    self.datePicker.maximumDate = maximumDate;
    if (date) {
        self.datePicker.date = date;
        [self birthdayPickerValueChange:self.datePicker];
    }
}

- (void)birthdayPickerValueChange:(UIDatePicker *)datePicker {
    NSDate *date = datePicker == nil ? [NSDate date] : datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    self.selectDate = date;
    df.dateFormat = @"yyyy年MM月dd日";
    self.selectDate1 = [df stringFromDate:date];
    df.dateFormat = @"yyyy-MM-dd";
    self.selectDate2 = [df stringFromDate:date];
}

#pragma mark - lazy load

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        // 设置时区
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        //设置时间模式
        // _datePicker.datePickerMode = UIDatePickerModeDate;
        
        // 设置最小时间（20年前）
        //_datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-(40 * 365 * 24 * 60 * 60)];
        // 设置最大时间（20年后）
        // _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(20 * 365 * 24 * 60 * 60)];
        // 设置最大时间 今天
        //_datePicker.maximumDate = [NSDate date];
        // 设置时间间隔
        // 设置的值必须能够被60整除
        //                _birthdayPicker.minuteInterval = 60;
        // 默认选中的日期
        //_datePicker.date = [NSDate dateWithTimeIntervalSinceNow:-(10 * 365 * 24 * 60 * 60)];
        // 监听时间改变事件
        [_datePicker addTarget:self action:@selector(birthdayPickerValueChange:) forControlEvents:UIControlEventValueChanged];
        
        // 默认选中今天
        [self birthdayPickerValueChange:nil];
    }
    return _datePicker;
}


@end
