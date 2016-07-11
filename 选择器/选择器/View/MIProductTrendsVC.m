//
//  MIProductTrendsVC.m
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIProductTrendsVC.h"
#import "MIProductTrendsCell.h"

static NSString * const kCellID = @"productTrendsCell";

@interface MIProductTrendsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation MIProductTrendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.mainTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _mainTable.dataSource = self;
    _mainTable.delegate = self;
    _mainTable.rowHeight = 80;
    [_mainTable registerNib:[UINib nibWithNibName:@"MIProductTrendsCell" bundle:nil] forCellReuseIdentifier:kCellID];
    
    [self.view addSubview:_mainTable];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MIProductTrendsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
