//
//  OptionModel.h
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionModel : NSObject

@property (nonatomic, strong) NSString *optionIndex;
@property (nonatomic, strong) NSString *optionText;
@property (nonatomic, strong) NSString *optionCount;// 总数
@property (nonatomic, strong) NSString *optionPercentage;// 比例

@end

