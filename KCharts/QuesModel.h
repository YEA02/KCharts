//
//  QuesModel.h
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuesModel : NSObject

@property (nonatomic, strong) NSString *quesTitle;// 问题名称
@property (nonatomic, strong) NSString *quesIndex;// 第几题
@property (nonatomic, strong) NSMutableArray *optionsArray;// 选项数组
@property NSUInteger Charttype;
@property BOOL isShowMenu;

@end

