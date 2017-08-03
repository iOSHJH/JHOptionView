//
//  ViewController.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ViewController.h"
#import "JHBaseOptionView.h"
#import "JHNormalOptionView.h"
#import "JHDateOptionView.h"
#import "JHAreaOptionView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSources;

@property (nonatomic, strong) JHBaseOptionView *optionView;

@property (nonatomic, strong) JHNormalOptionView *normalOptionView;

@property (nonatomic, strong) JHDateOptionView *dateOptionView;

@property (nonatomic, strong) JHAreaOptionView *areaOptionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = @[@"JHBaseOptionView", @"JHNormalOptionView", @"JHDateOptionView", @"JHAreaOptionView"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.optionView];
    [self.view addSubview:self.normalOptionView];
    [self.view addSubview:self.dateOptionView];
    [self.view addSubview:self.areaOptionView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.optionView show];
    }else if (indexPath.row == 1) {
        [self.normalOptionView setTitle:@"请选择字母" datas:@[@"a", @"b", @"c", @"d"] selectRow:2];
        [self.normalOptionView show];
        WeakSelf;
        self.normalOptionView.verifyBlock = ^{
            NSLog(@"%@ %zd",weakSelf.normalOptionView.selectTitle, weakSelf.normalOptionView.selectRow);
        };
        
//        [self.normalOptionView setTitle:@"请选择数字" datas:@[@"1", @"2", @"3", @"4"] selectRow:2];
//        [self.normalOptionView show];
    }else if (indexPath.row == 2) {
        
        //1、大范围用这种方式，大于 60年前或60年后
        NSString *minStr = @"1800-01-01";
        NSString *maxStr = @"2017-10-01";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *minDate = [dateFormatter dateFromString:minStr];
        NSDate *maxDate = [dateFormatter dateFromString:maxStr];
        
        //2、小范围可以用这种方式
        // 设置最小时间（20年前）
        //_datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-(40 * 365 * 24 * 60 * 60)];
        // 设置最大时间（20年后）
        //_datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(20 * 365 * 24 * 60 * 60)];
        
        [self.dateOptionView setTitle:@"请选择日期" dateMode:UIDatePickerModeDate minimumDate:minDate maximumDate:maxDate selectDate:[NSDate date]];
        [self.dateOptionView show];
        WeakSelf;
        self.dateOptionView.verifyBlock = ^{
            NSLog(@"%@ %@ %@",weakSelf.dateOptionView.selectDate1, weakSelf.dateOptionView.selectDate2, weakSelf.dateOptionView.selectDate);
        };
        
//        [self.dateOptionView setTitle:@"请选择时间" dateMode:UIDatePickerModeTime selectDate:nil];
//        [self.dateOptionView show];
        
    }else if (indexPath.row == 3) {
//        [self.areaOptionView setTitle:@"请选择工作地址" level:AreaOptionLevelcity firstComponentSelectRow:18];
//        [self.areaOptionView show];
        
        [self.areaOptionView setTitle:@"请选择家乡" level:AreaOptionLevelCounty firstComponentSelectRow:18];
        [self.areaOptionView show];
        WeakSelf;
        self.areaOptionView.verifyBlock = ^{
            NSLog(@"%@ %@ %@",weakSelf.areaOptionView.provinceStr, weakSelf.areaOptionView.cityStr, weakSelf.areaOptionView.countyStr);
        };
    }
}


- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width)];
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    return _tableView;
}

- (JHBaseOptionView *)optionView {
    if (_optionView) return _optionView;
    _optionView = [[JHBaseOptionView alloc] initWithFrame:self.view.bounds];
    return _optionView;
}

- (JHNormalOptionView *)normalOptionView {
    if (_normalOptionView) return _normalOptionView;
//    _normalOptionView = [[JHNormalOptionView alloc] initWithFrame:self.view.bounds];
    
    _normalOptionView = [JHNormalOptionView new];
    _normalOptionView.frame = self.view.bounds;
    
    return _normalOptionView;
}

- (JHDateOptionView *)dateOptionView {
    if (_dateOptionView) return _dateOptionView;
    _dateOptionView = [JHDateOptionView new];
    _dateOptionView.frame = self.view.bounds;
    
    return _dateOptionView;
}

- (JHAreaOptionView *)areaOptionView {
    if (_areaOptionView) return _areaOptionView;
    _areaOptionView = [[JHAreaOptionView alloc] initWithFrame:self.view.bounds];
    
    return _areaOptionView;
}



@end
