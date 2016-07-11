//
//  ViewController.m
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "ViewController.h"
#import "MIBaseLineChart.h"

#import "MIFoundChartResponse.h"
#import "MIFoundChartModel.h"

#import "MIChartNotice.h"

#import "MIInternetChart.h"

#define ROUNDUP(x,n) (round(x * pow(10,n))/pow(10,n))

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataModels;

@property (nonatomic, strong) NSArray *xMarks;

@property (nonatomic, strong) NSArray *currentYMarks;//非累计值的Y轴标注

@property (nonatomic, strong) NSArray *totalYMarks;//累计值的Y轴标注

@property (nonatomic, strong) NSArray *currntPointValues;//非累计值数组

@property (nonatomic, strong) NSArray *totalPointValues;//累计值数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tempData];
    [self prepareData];
    [self initChartView];
}


- (void)tempData {
    //JSON
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chartData" ofType:@"json"];
    NSDictionary *baseDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableContainers error:nil];
    //Model
    MIFoundChartResponse *chartResponse = [MTLJSONAdapter modelOfClass:[MIFoundChartResponse class] fromJSONDictionary:baseDic error:nil];
    self.dataModels = chartResponse.data;
    
}

- (void)prepareData {
    //拼接参数
    NSMutableArray *xMarks = [[NSMutableArray alloc] init];
    NSMutableArray *currentPointValues = [[NSMutableArray alloc] init];
    NSMutableArray *totalPointValues = [[NSMutableArray alloc] init];
    
    CGFloat maxCurrentY = 0;//非累计值最大值
    CGFloat maxTotalY = 0;//累计值最大值
    
    CGFloat minCurrentY = 0;//非累计值最小值
    CGFloat minTotalY = 0;//累计值最小值
    
    for (NSInteger index = 0; index < self.dataModels.count; index++) {
        MIFoundChartModel *model = self.dataModels[index];
        //XMark、CurrentPoint、TotalPoint
        NSString *date = model.date;
        [xMarks addObject:[date substringFromIndex:5]];
        [currentPointValues addObject:model.currentValue];
        [totalPointValues addObject:model.totalValue];
        //获取最大值最小值
        if (index) {
            //最大值
            if ([model.currentValue doubleValue] > maxCurrentY) {
                maxCurrentY = [model.currentValue doubleValue];
            }
            if ([model.totalValue doubleValue] > maxTotalY) {
                maxTotalY = [model.totalValue doubleValue];
            }
            //最小值
            if ([model.currentValue doubleValue] < minCurrentY) {
                minCurrentY = [model.currentValue doubleValue];
            }
            if ([model.totalValue doubleValue] < minTotalY) {
                minTotalY = [model.totalValue doubleValue];
            }
        }else {
            //最大值最小值初始化为第一次数据
            maxCurrentY = [model.currentValue doubleValue];
            maxTotalY = [model.totalValue doubleValue];
            
            minCurrentY = maxCurrentY;
            minTotalY = maxTotalY;
        }
    }
    //获取Y轴标注
    _currentYMarks = [self getYMarksWithMaxY:maxCurrentY minY:minCurrentY];
    _totalYMarks = [self getYMarksWithMaxY:maxTotalY minY:minTotalY];
    
    _xMarks = [NSArray arrayWithArray:xMarks];
    _currntPointValues = [NSArray arrayWithArray:currentPointValues];
    _totalPointValues = [NSArray arrayWithArray:totalPointValues];
}

- (NSArray *)getYMarksWithMaxY:(CGFloat)maxY minY:(CGFloat)minY {
    static NSInteger count = 5;
    if (maxY == minY) {
        NSLog(@"Error:折线图最大值等于最小值.绘图停止");
        return nil;
    }
    double value = (maxY - minY) / count;
    value = ROUNDUP(value, 4);
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < count + 1; index++) {
        double loopValue = minY + value * index;
        NSString *valueStr = [NSString stringWithFormat:@"%.4f",loopValue];
        [mutableArray addObject:valueStr];
    }
    return [NSArray arrayWithArray:mutableArray];
}

- (void)initChartView {
    MIBaseLineChart *chart = [[MIBaseLineChart alloc] initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 100, 205) XMarks:_xMarks YMarks:_currentYMarks PointValues:_currntPointValues];
    
    MIChartNotice *chartNotice = [MIChartNotice defaultChartNotice];
    chart.noticeView = chartNotice;
    
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
