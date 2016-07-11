//
//  MainViewController.m
//  LADemo-指纹
//
//  Created by 解炳灿 on 16/5/13.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"大家好，我是主页";
    [label sizeToFit];
    label.center = self.view.center;
    
    [self.view addSubview:label];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
