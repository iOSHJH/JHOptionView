//
//  JHNormalOptionView.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHBaseOptionView.h"

@interface JHNormalOptionView : JHBaseOptionView

@property (nonatomic, assign) NSInteger selectRow;
@property (nonatomic, copy) NSString *selectTitle;

/** 设置title、数据、选择行*/
- (void)setTitle:(NSString *)title datas:(NSArray *)datas selectRow:(NSInteger)row;


@end
