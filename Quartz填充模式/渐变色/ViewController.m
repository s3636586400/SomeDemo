//
//  ViewController.m
//  渐变色
//
//  Created by 解炳灿 on 16/4/28.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomView];
}

- (void)addCustomView {
    CustomView *customView = [[CustomView alloc] initWithFrame:self.view.frame];
    customView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
