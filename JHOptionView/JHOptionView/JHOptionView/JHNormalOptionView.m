//
//  JHNormalOptionView.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHNormalOptionView.h"

@interface JHNormalOptionView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray<NSString *> *datas;

@end

@implementation JHNormalOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.containView);
            make.top.equalTo(self.headView.mas_bottom);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.width.equalTo(self.containView.mas_width).multipliedBy(1/3.0);
        }];
    }
    return self;
}

/** 设置title、数据、选择行*/
- (void)setTitle:(NSString *)title datas:(NSArray *)datas selectRow:(NSInteger)row {
    self.titleLabel.text = title;
    self.datas = datas;
    self.selectRow = row;
    if (row < datas.count) {
        self.selectTitle = datas[row];
    }
}

- (void)setDatas:(NSArray<NSString *> *)datas {
    _datas = datas;
    
    [self.pickerView reloadAllComponents];
}

- (void)setSelectRow:(NSInteger)selectRow {
    _selectRow = selectRow;
    
    if (_selectRow >= self.datas.count) {
        return;
    }
    [self.pickerView selectRow:_selectRow inComponent:0 animated:YES];
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datas.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [UILabel new];
    label.text = self.datas[row];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HexRGB(0x1d1d1d);
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectTitle = self.datas[row];
    self.selectRow = row;
}

#pragma mark - get

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

@end
