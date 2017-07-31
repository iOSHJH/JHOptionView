//
//  JHAreaOptionView.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHAreaOptionView.h"
#import "Area.h"
#import "AreaDAL.h"

@interface JHAreaOptionView ()<UIPickerViewDataSource,UIPickerViewDelegate>

/** 地区级联, 默认是 AreaOptionLevelProvince*/
@property(nonatomic,assign) AreaOptionLevel level;
/** firstComponentSelectRow：选择第一列第几行*/
@property(nonatomic, assign) NSInteger firstComponentSelectRow;

@property (nonatomic,strong) NSArray<Area *> *areas;

/***  要显示的所有省*/
@property (nonatomic,strong) NSArray *provinces;
/***  要显示的所有市*/
@property (nonatomic,strong) NSArray *citys;
/***  要显示的所有县*/
@property (nonatomic,strong) NSArray *countys;

@property (nonatomic,strong) UIPickerView *areaPicker;

/***  记录选中的省*/
@property (nonatomic,strong) Area *province;
/***  记录选中的市*/
@property (nonatomic,strong) Area *city;
/***  记录选中的县、区*/
@property (nonatomic,strong) Area *county;


@end

@implementation JHAreaOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[AreaDAL sharedInstance] getAllTAreasFinished:^(NSArray *areas, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.areas = areas;
                        });
        
                    }];
                });
        
//        [[AreaDAL sharedInstance] getAllTAreasFinished:^(NSArray *areas, NSError *error) {
//            self.areas = areas;
//            
//        }];
        
        [self.containView addSubview:self.areaPicker];
        
        [self.areaPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.headView.mas_bottom);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.width.equalTo(self.containView.mas_width).multipliedBy(7.0/8.0);
        }];
    }
    return self;
}

/** 设置 title、级联、选择第一列的哪行*/
- (void)setTitle:(NSString *)title level:(AreaOptionLevel)level firstComponentSelectRow:(NSInteger)row {
    self.titleLabel.text = title;
    self.level = level;
    self.firstComponentSelectRow = row;
}

/** 根据当前地区 获取 下级地区的所有地区.比如传入一个省，那么就能获得这个省下的所有城市*/
- (NSArray *)getLowerLevelTAreas:(Area *)higherArea {
    NSMutableArray *array = [NSMutableArray array];
    for (Area *area in self.areas) {
        if ([area.pid isEqualToString:higherArea.id]) {
            [array addObject:area];
        }
    }
    return array;
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.level;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.provinces.count;
            break;
        case 1:
            return self.citys.count;
            break;
        case 2:
            return self.countys.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = HexRGB(0x4D4D4D);
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(30, 0, 70, 70);
    
    Area *area = nil;
    
    switch (component) {
        case 0:
            area = self.provinces[row];
            self.province = area;
            break;
        case 1:
            area = self.citys[row];
            self.city = area;
            break;
        case 2:
            area = self.countys[row];
            self.county = area;
            break;
        default:
            return nil;
            break;
    }
    label.text = area.area_name;
    
    if (_level == AreaOptionLevelProvince) {
        self.provinceStr = self.province.area_name;
        self.cityStr = nil;
        self.countyStr = nil;
    }else if (_level == AreaOptionLevelcity) {
        self.provinceStr = self.province.area_name;
        self.cityStr = self.city.area_name;
        self.countyStr = nil;
    }else {
        self.provinceStr = self.province.area_name;
        self.cityStr = self.city.area_name;
        self.countyStr = self.county.area_name;
    }
    
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.firstComponentSelectRow = row;
        
        self.province = self.provinces[row];
        self.citys = [self getLowerLevelTAreas:self.province];
        Area *city = self.citys.firstObject;
        self.countys = [self getLowerLevelTAreas:city];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else if (component == 1) {
        self.city = self.citys[row];
        self.countys = [self getLowerLevelTAreas:self.city];
        
        if (self.level == AreaOptionLevelCounty) {
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }else if (component == 2) {
        self.county = self.countys[row];
    }
    
    [pickerView reloadAllComponents];
}

#pragma mark - get

- (UIPickerView *)areaPicker {
    if (!_areaPicker) {
        _areaPicker = [[UIPickerView alloc] init];
        _areaPicker.backgroundColor = [UIColor whiteColor];
        _areaPicker.dataSource = self;
        _areaPicker.delegate = self;
    }
    return _areaPicker;
}

#pragma mark - setter

- (void)setAreas:(NSArray<Area *> *)areas {
    _areas = areas;
    
    /***  默认显示第一行的 地区*/
    NSMutableArray *arr1 = [NSMutableArray array];
    
    for (Area *area in _areas) {
        if ([area.level isEqualToString:@"1"]) { // 省
            [arr1 addObject:area];
        }
    }
    self.provinces = arr1;
    
    
    Area *firstProvince = self.provinces.firstObject;
    // 第一个省的所有城市
    self.citys = [self getLowerLevelTAreas:firstProvince];
    
    Area *firstCity = self.citys.firstObject;
    self.countys = [self getLowerLevelTAreas:firstCity];
    
    [self.areaPicker reloadAllComponents];
}

- (void)setFirstComponentSelectRow:(NSInteger)firstComponentSelectRow {
    _firstComponentSelectRow = firstComponentSelectRow;
    
    //NSAssert(self.firstComponentSelectRow < self.provinces.count, @"第一列没有这么多行，数组越界");
    if (self.firstComponentSelectRow >= self.provinces.count) {
        return;
    }
    
    [self.areaPicker selectRow:self.firstComponentSelectRow inComponent:0 animated:YES];
    
    Area *province = self.provinces[self.firstComponentSelectRow];
    self.citys = [self getLowerLevelTAreas:province];
    
    if (self.level == AreaOptionLevelCounty){
        Area *firstCity = self.citys.firstObject;
        self.countys = [self getLowerLevelTAreas:firstCity];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.areaPicker reloadAllComponents];
    });
}

- (void)setLevel:(AreaOptionLevel)level {
    _level = level;

    [self.areaPicker reloadAllComponents];
}

@end

