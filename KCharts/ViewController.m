//
//  ViewController.m
//  KCharts
//
//  Created by csdc-iMac on 2018/11/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import "ViewController.h"
//#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "QuesResultCellView.h"
#import "OptionModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,changeChartDelegate>

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
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(10, 15, self.view.frame.size.width - 20, 45)];
    vie.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vie];
    
    UILabel *textView1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width - 15, 25)];
    textView1.text = @"问卷名称：这是一个选择题";
    [vie addSubview:textView1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height)];
    self.tableView.tableHeaderView = vie;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
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
//    NSLog(@"%f",[tableView cellHeightForIndexPath:indexPath model:self.quesArray[indexPath.row] keyPath:@"model" cellClass:[QuesResultCellView class] contentViewWidth:[self cellContentViewWith]]);
//    return 580;
    return [tableView cellHeightForIndexPath:indexPath model:self.quesArray[indexPath.row] keyPath:@"model" cellClass:[QuesResultCellView class] contentViewWidth:[self cellContentViewWith]];
    
}

- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
