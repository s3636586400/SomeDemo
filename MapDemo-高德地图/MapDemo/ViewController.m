//
//  ViewController.m
//  MapDemo
//
//  Created by 解炳灿 on 16/4/13.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) NSArray *classes;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitles];
    [self initClasses];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initView {
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.title = @"Map Demo";
}

- (void)initTitles {
    self.titles = @[@"单次定位",
                    @"持续定位",
                    @"基本地图",
                    @"大头针标注",
                    @"自定义标注"];
}

- (void)initClasses {
    self.classes = @[@"MILocateViewController",
                     @"MIBackgroundLocateController",
                     @"BaseMapController",
                     @"MIPinAnnotationController",
                     @"MIAnnotationController"];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell) {
        cell.textLabel.text = self.titles[indexPath.row];
        cell.detailTextLabel.text = self.classes[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Location Kit";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:self.classes[indexPath.row]];
    UIViewController *vc = [[NSClassFromString(self.classes[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
