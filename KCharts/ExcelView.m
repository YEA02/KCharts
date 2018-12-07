//
//  ExcelView.m
//  KCharts
//
//  Created by csdc-iMac on 2018/12/7.
//  Copyright © 2018年 K. All rights reserved.
//

#import "ExcelView.h"

@implementation ExcelView

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSMutableArray *)titleArr andNumArr:(NSMutableArray *)numArr {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 40)];
        titleLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        titleLab.layer.borderWidth = 1;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"选项";
        [self addSubview:titleLab];
        
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 70, 40)];
        numLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        numLab.layer.borderWidth = 1;
        numLab.textAlignment = NSTextAlignmentCenter;
        numLab.text = @"小计";
        [self addSubview:numLab];
        
        UILabel *percentLab = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 70, 40)];
        percentLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        percentLab.layer.borderWidth = 1;
        percentLab.textAlignment = NSTextAlignmentCenter;
        percentLab.text = @"比例";
        [self addSubview:percentLab];
        
        UIView *lastView = (UIView *)titleLab;
        CGFloat allHeight = 40;
        
        for(int i = 0; i<titleArr.count;i++) {
            
            CGRect viewframe = [titleArr[i] boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:NULL];
            CGFloat height = 30;
            if (viewframe.size.height > 20) {
                height = viewframe.size.height + 10;
            }
            
            allHeight = allHeight + height;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lastView.frame.origin.y + lastView.frame.size.height, 350, height)];
            lineView.backgroundColor = [UIColor whiteColor];
            [self addSubview:lineView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, height)];
            lab.layer.borderColor = [UIColor lightGrayColor].CGColor;
            lab.layer.borderWidth = 1;
            lab.numberOfLines = 0;
            [lineView addSubview:lab];
            
            UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, height - 10)];
            lab2.textAlignment = NSTextAlignmentCenter;
            lab2.font = [UIFont systemFontOfSize:15];
            lab2.text = titleArr[i];
            lab2.numberOfLines = 0;// 允许换行
            [lab addSubview:lab2];
            
            UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 70, height)];
            numberLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
            numberLab.textAlignment = NSTextAlignmentCenter;
            numberLab.font = [UIFont systemFontOfSize:15];
            numberLab.layer.borderWidth = 1;
            numberLab.text = numArr[2*i];
            [lineView addSubview:numberLab];
            
            UILabel *perLab = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 70, height)];
            perLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
            perLab.textAlignment = NSTextAlignmentCenter;
            perLab.font = [UIFont systemFontOfSize:15];
            perLab.layer.borderWidth = 1;
            perLab.text = numArr[2*i + 1];
            [lineView addSubview:perLab];
            
            lastView = lineView;
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, allHeight);
        
    }
    return self;
}

@end
