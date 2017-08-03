//
//  JHBaseOptionView.m
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHBaseOptionView.h"

@implementation JHBaseOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
//        self.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
//        [self addGestureRecognizer:tap];
        [self prepareUI];
    }
    self.alpha = 0;
    return self;
}

- (void)prepareUI {
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.8;
    
    [self addSubview:self.containView];
    [self.containView addSubview:self.headView];
    [self.headView addSubview:self.titleLabel];
    [self addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.cancelButton];
    [self.bottomView addSubview:self.verifyButton];
    [self.bottomView addSubview:self.dividerView];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(width);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.containView);
        make.height.mas_equalTo(49);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).mas_offset(10);
        make.centerY.equalTo(self.headView);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView);
        make.bottom.equalTo(self.containView.mas_bottom);
        make.width.height.equalTo(self.headView);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView);
        make.right.equalTo(self.dividerView.mas_left);
        make.top.equalTo(self.bottomView).offset(0.5);
        make.height.equalTo(self.bottomView);
        make.width.equalTo(self.verifyButton);
    }];
    
    [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelButton.mas_right);
        make.centerY.equalTo(self.cancelButton);
        make.width.mas_equalTo(1);
        make.height.equalTo(self.cancelButton).multipliedBy(0.5);
    }];
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dividerView);
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView).offset(0.5);
        make.height.equalTo(self.bottomView);
        make.width.equalTo(self.cancelButton);
    }];
}

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark - action

- (void)cancelClick {
    [self hide];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)verifyClick {
    [self hide];
    if (self.verifyBlock) {
        self.verifyBlock();
    }
}

#pragma mark - lazy load

- (UIView *)containView {
    if (_containView) return _containView;
    _containView = [[UIView alloc] init];
    _containView.backgroundColor = [UIColor whiteColor];
    return _containView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = HexRGB(0xffd800);
    }
    return _headView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HexRGB(0x1d1d1d);
    }
    return _titleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1];
    }
    return _bottomView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:HexRGB(0x4D4D4D) forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)verifyButton {
    if (!_verifyButton) {
        _verifyButton = [UIButton new];
        [_verifyButton setTitle:@"确定" forState:UIControlStateNormal];
        [_verifyButton setTitleColor:HexRGB(0x4D4D4D) forState:UIControlStateNormal];
        [_verifyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _verifyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_verifyButton setBackgroundColor:[UIColor whiteColor]];
        [_verifyButton addTarget:self action:@selector(verifyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyButton;
}

- (UIView *)dividerView {
    if (!_dividerView) {
        _dividerView = [UIView new];
        _dividerView.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1];
    }
    return _dividerView;
}

@end
