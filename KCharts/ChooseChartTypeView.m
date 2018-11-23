//
//  SRDBChooseChartTypeView.m
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 Cloudox. All rights reserved.
//

#import "ChooseChartTypeView.h"

@interface ChooseChartTypeView ()

@property (nonatomic, strong) NSArray *titleArray;// 标题数组

@end

@implementation ChooseChartTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = [NSArray arrayWithObjects:@"柱状图", @"饼状图", @"网状图", nil];
        // 阴影颜色
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        // 阴影偏移
        self.layer.shadowOffset = CGSizeMake(0, 0);
        // 阴影透明度
        self.layer.shadowOpacity = 0.8;
        // 阴影半径
        self.layer.shadowRadius = 3.0;
        [self.layer setCornerRadius:4.0];// 设置圆角
        for (int i = 0; i < self.titleArray.count; i++) {
            // 点击响应
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTarget:)];
            
            // 背景
            UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 30*i, 60, 30)];
            bg.backgroundColor = [UIColor whiteColor];
            bg.tag = i;
            
            bg.userInteractionEnabled = YES;
            [bg addGestureRecognizer:recognizer];
            [self addSubview:bg];
            
            
            // 文字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
            label.text = [self.titleArray objectAtIndex:i];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentCenter;
            [bg addSubview:label];
            
        }
    }
    return self;
}

// 点击目标
- (void)clickTarget:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(selectTarget:)]) {
        [self.delegate selectTarget:[self.titleArray objectAtIndex:recognizer.view.tag]];
    }
}

@end
