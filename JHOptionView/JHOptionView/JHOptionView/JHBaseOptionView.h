//
//  JHBaseOptionView.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseOptionView : UIView

@property (nonatomic, strong) UIView *containView;
/***  头部view*/
@property (nonatomic,strong) UIView *headView;
/***  标题*/
@property (nonatomic,strong) UILabel *titleLabel;
/***  底部view*/
@property (nonatomic,strong) UIView *bottomView;
/***  取消按钮*/
@property (nonatomic,strong) UIButton *cancelButton;
/***  确认按钮*/
@property (nonatomic,strong) UIButton *verifyButton;
/***  分割线*/
@property (nonatomic,strong)  UIView *dividerView;

/***  取消block*/
@property (nonatomic,copy) void(^cancelBlock)();
/***  确认block*/
@property (nonatomic,copy) void(^verifyBlock)();

- (void)show;

- (void)hide;

@end
