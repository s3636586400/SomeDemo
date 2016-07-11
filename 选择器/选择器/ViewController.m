//
//  ViewController.m
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import "MICategorySelector.h"
#import "MIProductTrendsVC.h"

#import "AppMarco.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MICategorySelector *selector = [MICategorySelector defaultSelector:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50) titles:@[@"产品动态",@"客户动态",@"课程动态",@"系统通知"]];
    [self.view addSubview:selector];
    
    MIProductTrendsVC *productTrends = [[MIProductTrendsVC alloc] init];
    productTrends.view.frame = CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT - 70);
    [self.view addSubview:productTrends.view];
    [self addChildViewController:productTrends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
