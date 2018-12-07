//
//  QuesResultCellView.m
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.


#import "QuesResultCellView.h"
#import "UIView+SDAutoLayout.h"
#import "KCharts-Bridging-Header.h"
#import "OptionModel.h"
#import "ChooseChartTypeView.h"
#import "ExcelView.h"

@interface QuesResultCellView () <ChartViewDelegate,ChooseChartTypeDelegate>

@property (nonatomic, strong) UIView *allView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ExcelView *excelView;// 表格
@property (nonatomic, strong) BarChartView *barChartView;// 柱状图
@property (nonatomic, strong) PieChartView *pieChartView;// 饼状图
@property (nonatomic, strong) RadarChartView *radarChartView;// 网状图
@property (nonatomic, strong) ChartXAxis *xAxis;
@property (nonatomic, strong) ChartYAxis *leftAxis;
@property (nonatomic, strong) UIButton *targetBtn;// 选择图表类型
@property BOOL isShowTargetView;// 是否显示了所有图表类型
@property (nonatomic, strong) ChooseChartTypeView *chooseChartTypeView;
@property (nonatomic, strong) NSMutableArray *resultPercentageArray;// 选项占比数组
@property (nonatomic, strong) NSMutableArray *colors;// 颜色数组
@end

@implementation QuesResultCellView
{
    NSUInteger typeId;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.resultnNameArray = [[NSMutableArray alloc] init];
        self.resultCountArray = [[NSMutableArray alloc] init];
        self.resultAllArray = [[NSMutableArray alloc] init];
        self.resultPercentageArray = [[NSMutableArray alloc] init];
        self.colors = [[NSMutableArray alloc] init];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    // 颜色
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor colorWithRed:192/255.f green:255/255.f blue:140/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:255/255.f green:247/255.f blue:140/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:255/255.f green:208/255.f blue:140/255.f alpha:1.f]];
    [colors addObject:[UIColor colorWithRed:140/255.f green:234/255.f blue:255/255.f alpha:1.f]];
    
    self.colors = colors;
    
    self.allView = [[UIView alloc] init];
    self.allView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.allView];
    
    self.allView.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0);
    
}

//为柱形图设置数据
- (BarChartData *)setdata{
    
    self.barChartView.xAxis.labelCount = self.resultnNameArray.count;// 横轴坐标显示个数
    self.barChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.resultnNameArray]; //设置横轴数据
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i =0; i < self.resultCountArray.count;i++) {
        
        int yvalue = [self.resultCountArray[i] intValue];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:yvalue data:self.resultnNameArray[i]];
        [yVals addObject:entry];//Y轴上面需要显示的数据
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:nil];
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    set1.colors = self.colors;//设置柱形图颜色
    
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [formatter setPositiveFormat:@"#0"];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    return data;
}

//为饼状图设置数据
- (PieChartData *)setData{
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.resultnNameArray.count; i++) {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[self.resultPercentageArray[i] doubleValue] label:self.resultnNameArray[i]]];
    }// label就是图例的名称
    
    PieChartDataSet *set1 = [[PieChartDataSet alloc] initWithValues:values label:nil];
    
    set1.colors = self.colors;// 区块颜色
    set1.sliceSpace = 2.0;//相邻区块之间的间距
    
    //创建PieChartData对象, 此对象就是barChartView需要最终数据对象
    PieChartData *data = [[PieChartData alloc] initWithDataSet:set1];
    
    // 设置数据格式
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 2;// 小数位数
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";// 百分号
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    
    return data;
}

//为网状图设置数据
- (RadarChartData *)setRadarData{
    
    self.radarChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.resultnNameArray]; //设置横轴数据
    
    // 维度的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i =0; i < self.resultCountArray.count;i++) {
        int yvalue = [self.resultCountArray[i] intValue];
        RadarChartDataEntry *entry = [[RadarChartDataEntry alloc] initWithValue:yvalue];
        [yVals addObject:entry];//Y轴上面需要显示的数据
    }
    
    //创建RadarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:yVals label:@""];
    set1.drawFilledEnabled = YES;// 是否填充颜色
    set1.fillColor = [UIColor lightGrayColor];// 填充颜色
    
    //创建RadarChartData对象, 此对象就是barChartView需要最终数据对象
    RadarChartData *data = [[RadarChartData alloc] initWithDataSet:set1];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //自定义数据显示格式
    [formatter setPositiveFormat:@"#0"];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    
    return data;
}

- (void)setModel:(QuesModel *)model{
    
    [self.resultAllArray removeAllObjects];
    [self.resultCountArray removeAllObjects];
    [self.resultnNameArray removeAllObjects];
    [self.resultPercentageArray removeAllObjects];
    
    for (int i=0;i<model.optionsArray.count;i++) {
        OptionModel *optionModel = [[OptionModel alloc] init];
        optionModel = model.optionsArray[i];
        [self.resultnNameArray addObject:optionModel.optionText];
        [self.resultCountArray addObject:optionModel.optionCount];
        [self.resultPercentageArray addObject:optionModel.optionPercentage];
        [self.resultAllArray addObject:optionModel.optionCount];
        [self.resultAllArray addObject:optionModel.optionPercentage];
    }
    
    //题号标签
    self.numberLabel = [[UILabel alloc] init];
    [self.allView addSubview:self.numberLabel];
    
    //题目名称
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.numberOfLines = 0;
    [self.allView addSubview:self.nameLabel];
    
    self.numberLabel.text = [NSString stringWithFormat:@"第%d题：", [model.quesIndex intValue]+1]; 
    self.nameLabel.text = model.quesTitle;
    
    // 选项表
    self.excelView = [[ExcelView alloc] initWithFrame:CGRectMake(10, 120, 350, 0) andTitleArray:self.resultnNameArray andNumArr:self.resultAllArray];
    [self.allView addSubview:self.excelView];
    
    // 图表样式
    self.targetBtn = [[UIButton alloc] init];
    [self.targetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.targetBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.targetBtn addTarget:self action:@selector(chooseTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.allView addSubview:self.targetBtn];
    
    // 三角形
    UIImageView *triangleImg = [[UIImageView alloc] init];
    triangleImg.image = [UIImage imageNamed:@"ic_survey_triangle"];
    [self.allView addSubview:triangleImg];
    
    if (model.Charttype == 1) {
        [self.targetBtn setTitle:@"柱状图" forState:UIControlStateNormal];
        [self drawBarChart];
    } else if (model.Charttype == 2) {
        [self.targetBtn setTitle:@"饼状图" forState:UIControlStateNormal];
        [self drawPieChart];
    } else {
        [self.targetBtn setTitle:@"网状图" forState:UIControlStateNormal];
        [self drawRadarChart];
    }
    
    // 题目标签
    self.numberLabel.sd_layout
    .leftSpaceToView(self.allView, 15)
    .widthIs(70)
    .heightIs(30)
    .topSpaceToView(self.allView, 5);
    
    // 题目名称
    self.nameLabel.sd_layout
    .leftSpaceToView(self.numberLabel, 0)
    .rightSpaceToView(self.allView, 0)
    .topSpaceToView(self.allView, 10)
    .autoHeightRatio(0);
    
    // 表格
    self.excelView.sd_layout
    .leftSpaceToView(self.allView, 20)
    .rightSpaceToView(self.allView, 20)
    .topSpaceToView(self.nameLabel, 20)
    .heightIs(self.excelView.frame.size.height);
    NSLog(@"%f",self.excelView.frame.size.height);
    triangleImg.sd_layout
    .rightSpaceToView(self.allView, 25)
    .topSpaceToView(self.excelView, 23)
    .widthIs(5)
    .heightIs(5);
    
    self.targetBtn.sd_layout
    .rightSpaceToView(triangleImg, 5)
    .topSpaceToView(self.excelView, 5)
    .widthIs(50)
    .heightIs(25);
    
    if (model.Charttype == 1) {
        // 柱状图
        self.barChartView.sd_layout
        .leftSpaceToView(self.allView, 15)
        .rightEqualToView(self.excelView)
        .heightIs(350)
        .topSpaceToView(self.targetBtn, 8);
        [self.allView setupAutoHeightWithBottomView:self.barChartView bottomMargin:5];
        self.barChartView.data = [self setdata];
    } else if (model.Charttype == 2) {
        // 饼状图
        self.pieChartView.sd_layout
        .leftSpaceToView(self.allView, 15)
        .rightEqualToView(self.excelView)
        .heightIs(350)
        .topSpaceToView(self.targetBtn, 8);
        
        [self.allView setupAutoHeightWithBottomView:self.pieChartView bottomMargin:5];
      
        self.pieChartView.data = [self setData];
    } else {
        // 网状图
        self.radarChartView.sd_layout
        .leftSpaceToView(self.allView, 15)
        .rightEqualToView(self.excelView)
        .heightIs(350)
        .topSpaceToView(self.targetBtn, 8);
        
        [self.allView setupAutoHeightWithBottomView:self.radarChartView bottomMargin:5];
        
        self.radarChartView.data = [self setRadarData];
    }
     NSLog(@"%lf",self.allView.frame.size.height);
     [self setupAutoHeightWithBottomView:self.allView bottomMargin:0];
        
}

- (void)drawBarChart {
    // 柱状图
    self.barChartView = [[BarChartView alloc] init];
    self.barChartView.backgroundColor = [UIColor whiteColor];
    self.barChartView.delegate = self;
    
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    self.barChartView.legend.enabled = YES;// 底部显示图例
    self.barChartView.legend.font = [UIFont systemFontOfSize:10];// 字体大小
    self.barChartView.legend.textColor = [UIColor blackColor];// 字体颜色
    self.barChartView.legend.formToTextSpace = 5;// 文本间隔
    self.barChartView.legend.formSize = 12;// 图示大小
    self.barChartView.legend.maxSizePercent = 1;
    self.barChartView.noDataText = @"没有数据";
    [self.allView addSubview:self.barChartView];
    
    //X轴样式
    self.xAxis = self.barChartView.xAxis;
    self.xAxis.axisLineWidth = 1;//设置X轴线宽
    self.xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    self.xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    self.xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    
    //右边Y轴样式
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    
    //左边Y轴样式
    self.leftAxis = self.barChartView.leftAxis;//获取左边Y轴
    self.leftAxis.forceLabelsEnabled = NO;// 不强制绘制制定数量的label
    self.leftAxis.drawGridLinesEnabled = NO;// 不绘制网格线
    self.leftAxis.axisMinimum = 0;//设置Y轴的最小值
    self.leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    self.leftAxis.axisLineWidth = 0.5;//Y轴线宽
    self.leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @"#0.0";
    
    self.leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    self.leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    self.leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
    self.leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
}

// 饼状图
- (void)drawPieChart {
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor whiteColor];
    self.pieChartView.delegate = self;
    [self.allView addSubview:self.pieChartView];
    
    self.pieChartView.usePercentValuesEnabled = YES;// 百分比格式
    self.pieChartView.drawHoleEnabled = NO;// 是否空心
    self.pieChartView.dragDecelerationEnabled = NO;// 拖拽后是否有惯性效果
    self.pieChartView.noDataText = @"没有数据";
    
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];// 字体大小
    self.pieChartView.legend.textColor = [UIColor blackColor];// 字体颜色
    self.pieChartView.legend.formToTextSpace = 5;// 文本间隔
    self.pieChartView.legend.formSize = 12;// 图示大小
    self.pieChartView.legend.maxSizePercent = 1;
    
    self.pieChartView.legend.orientation = ChartLegendOrientationHorizontal;
    
}

// 网状图
- (void)drawRadarChart {
    self.radarChartView = [[RadarChartView alloc] init];
    self.radarChartView.backgroundColor = [UIColor whiteColor];
    [self.allView addSubview:self.radarChartView];
    
    self.radarChartView.legend.enabled = NO;// 不显示图例
    self.radarChartView.delegate = self;
    self.radarChartView.rotationEnabled = NO;//是否允许转动
    self.radarChartView.highlightPerTapEnabled = NO;//是否能被选中
    
    self.radarChartView.webLineWidth = 0.5;//主干线线宽
    self.radarChartView.innerWebLineWidth = 0.375;//边线宽度
    self.radarChartView.webAlpha = 1;//透明度
    self.radarChartView.noDataText = @"没有数据";
    
    //X轴样式
    ChartXAxis *xAxis = self.radarChartView.xAxis;
    xAxis.axisLineWidth = 1;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    
    
    ChartYAxis *yAxis = self.radarChartView.yAxis;
    yAxis.axisMinimum = 0.0;// 最小值
    yAxis.labelCount = self.resultnNameArray.count;// label个数
    yAxis.labelTextColor = [UIColor blackColor];//文字颜色
    yAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @"#0.0";
    yAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    
}

// 显示搜索目标下拉框
- (void)chooseTarget:(UIButton *)button {
    if(self.isShowTargetView){// 点击时是显示状态
        [self.chooseChartTypeView removeFromSuperview];
    }else{// 点击时没有显示
        if(self.chooseChartTypeView == nil){
            self.chooseChartTypeView = [[ChooseChartTypeView alloc] init];
            self.chooseChartTypeView.delegate = self;
        }
        [self.allView addSubview:self.chooseChartTypeView];
        self.chooseChartTypeView.sd_layout
        .rightSpaceToView(self.allView, 46)
        .topSpaceToView(self.excelView, 10)
        .widthIs(50)
        .heightIs(90);
        
    }
    self.isShowTargetView = !self.isShowTargetView;
}

#pragma mark - SRDBChooseTargetView Delegate
// 选择搜索目标
- (void)selectTarget:(NSString *)target{
    // 收起下拉框
    [self.chooseChartTypeView removeFromSuperview];
    self.isShowTargetView = !self.isShowTargetView;
    if ([target isEqualToString:@"柱状图"]) {
        typeId = 1;
    } else if ([target isEqualToString:@"饼状图"]) {
        typeId = 2;
    } else {
        typeId = 3;
    }
    [self.delegate changeChart:self andType:typeId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

