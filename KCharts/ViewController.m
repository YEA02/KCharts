//
//  ViewController.m
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "QuesResultCellView.h"
#import "OptionModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,changeChartDelegate>

@property (nonatomic, strong) UIScrollView *allView;
@property (nonatomic, strong) NSMutableArray *quesArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QuesModel *quesModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"chart";
    self.view.backgroundColor = [UIColor whiteColor];
    self.quesArray = [[NSMutableArray alloc] init];
    
    [self getStatistics];
    [self createUI];
    
}

- (void)createUI {
    self.allView = [[UIScrollView alloc] init];
    self.allView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.allView];
    
    UIView *vie = [[UIView alloc] init];
    vie.backgroundColor = [UIColor whiteColor];
    vie.layer.cornerRadius = 4.0;
    [self.allView addSubview:vie];
    
    UITextField *textView1 = [[UITextField alloc] init];
    textView1.text = @"问卷名称：这是一个选择题";
    [vie addSubview:textView1];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.scrollEnabled = NO;
    [self.allView addSubview:self.tableView];
    
    self.allView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    vie.sd_layout
    .leftSpaceToView(self.allView, 10)
    .rightSpaceToView(self.allView, 10)
    .topSpaceToView(self.allView, 15)
    .heightIs(45);
    
    textView1.sd_layout
    .leftSpaceToView(vie, 15)
    .rightSpaceToView(vie, 0)
    .topSpaceToView(vie, 10)
    .heightIs(25);
    
    self.tableView.sd_layout
    .leftSpaceToView(self.allView, 10)
    .rightSpaceToView(self.allView, 10)
    .topSpaceToView(vie, 5)
    .heightIs(630 * self.quesArray.count);
    
    [self.allView setupAutoHeightWithBottomView:self.tableView bottomMargin:5];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.quesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleCell = @"SimpleCell";
    QuesResultCellView *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[QuesResultCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleCell];
    }
    cell.delegate = self;
    [cell setModel:self.quesArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 630;
}

-(void)changeChart:(QuesResultCellView *)cell andType:(NSUInteger)i {
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    QuesModel *quesModel = [[QuesModel alloc] init];
    quesModel = self.quesArray[indexpath.row];
    quesModel.Charttype = i;
    [self.quesArray replaceObjectAtIndex:indexpath.row withObject:quesModel];
    [self.tableView reloadData];
}

- (void)getStatistics {
    
    QuesModel *quesModel = [[QuesModel alloc] init];
    quesModel.optionsArray = [[NSMutableArray alloc] init];
    quesModel.quesTitle = @"这是第一题";
    quesModel.quesIndex = @"0";
    quesModel.Charttype = 1;

    OptionModel *optionModel11 = [[OptionModel alloc] init];
    optionModel11.optionText = @"A";
    optionModel11.optionIndex = @"0";
    optionModel11.optionCount = @"15";
    optionModel11.optionPercentage = @"30%";
    [quesModel.optionsArray addObject:optionModel11];
    
    OptionModel *optionModel12 = [[OptionModel alloc] init];
    optionModel12.optionText = @"B";
    optionModel12.optionIndex = @"1";
    optionModel12.optionCount = @"25";
    optionModel12.optionPercentage = @"50%";
    [quesModel.optionsArray addObject:optionModel12];
    
    OptionModel *optionModel13 = [[OptionModel alloc] init];
    optionModel13.optionText = @"c";
    optionModel13.optionIndex = @"2";
    optionModel13.optionCount = @"10";
    optionModel13.optionPercentage = @"20%";
    [quesModel.optionsArray addObject:optionModel13];
    [self.quesArray addObject:quesModel];
    
    QuesModel *quesModell = [[QuesModel alloc] init];
    quesModell.optionsArray = [[NSMutableArray alloc] init];
    quesModell.quesTitle = @"这是第2题";
    quesModell.quesIndex = @"1";
    quesModell.Charttype = 1;
    
    OptionModel *optionModell11 = [[OptionModel alloc] init];
    optionModell11.optionText = @"A";
    optionModell11.optionIndex = @"0";
    optionModell11.optionCount = @"40";
    optionModell11.optionPercentage = @"10%";
    [quesModell.optionsArray addObject:optionModell11];
    
    OptionModel *optionModell12 = [[OptionModel alloc] init];
    optionModell12.optionText = @"B";
    optionModell12.optionIndex = @"1";
    optionModell12.optionCount = @"300";
    optionModell12.optionPercentage = @"75%";
    [quesModell.optionsArray addObject:optionModell12];
    
    OptionModel *optionModell13 = [[OptionModel alloc] init];
    optionModell13.optionText = @"c";
    optionModell13.optionIndex = @"2";
    optionModell13.optionCount = @"60";
    optionModell13.optionPercentage = @"15%";
    [quesModell.optionsArray addObject:optionModell13];
    
    [self.quesArray addObject:quesModell];
    
}



@end
