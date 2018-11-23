//
//  QuesResultCellView.h
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuesModel.h"

@class QuesResultCellView;

@protocol changeChartDelegate <NSObject>

- (void)changeChart:(QuesResultCellView *)cell andType:(NSUInteger)i;

@end

@interface QuesResultCellView : UITableViewCell
@property (nonatomic, strong) NSMutableArray *quesArray;// 问题数组
@property (nonatomic, strong) NSMutableArray *resultnNameArray;// 选项数组
@property (nonatomic, strong) NSMutableArray *resultAllArray;// 选项数目数组
@property (nonatomic, strong) NSMutableArray *resultCountArray;// 选项总数数组
@property (nonatomic, weak) id <changeChartDelegate> delegate;
- (void)setModel:(QuesModel *)model;
@end




