//
//  ViewController.m
//  BaseProject
//
//  Created by 解炳灿 on 16/4/22.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

#define CELL_ID @"cellID"

#define HEAD_TITLE @"BaseProject"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTable;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *classNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initView {
    self.mainTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_ID];
    
    [self.view addSubview:self.mainTable];
}

- (void)initData {
    self.titles = @[];
    self.classNames = @[];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return HEAD_TITLE;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = [self.classNames objectAtIndex:indexPath.row];
    UIViewController *controller = [[NSClassFromString(className) alloc] init];
    controller.title = [self.titles objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
