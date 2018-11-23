//
//  ChooseChartTypeView.h
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseChartTypeDelegate <NSObject>

// 选择搜索目标
- (void)selectTarget:(NSString *)target;

@end

@interface ChooseChartTypeView : UIView

@property (nonatomic, weak) id <ChooseChartTypeDelegate> delegate;

@end
