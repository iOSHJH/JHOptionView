//
//  JHAreaOptionView.h
//  JHOptionView
//
//  Created by 黄俊煌 on 2017/7/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "JHBaseOptionView.h"

typedef enum {
    AreaOptionLevelProvince = 1, // 省      一级联动
    AreaOptionLevelcity,     // 市      二级联动
    AreaOptionLevelCounty    // 县、区   三级联动
}AreaOptionLevel;

@interface JHAreaOptionView : JHBaseOptionView

/** 设置 title、级联、选择第一列的哪行*/
- (void)setTitle:(NSString *)title level:(AreaOptionLevel)level firstComponentSelectRow:(NSInteger)row;

/***  选中的省*/
@property (nonatomic,copy) NSString *provinceStr;
/***  选中的市*/
@property (nonatomic,copy) NSString *cityStr;
/***  选中的县、区*/
@property (nonatomic,copy) NSString *countyStr;

@end
