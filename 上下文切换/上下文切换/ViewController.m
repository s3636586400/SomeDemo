//
//  ViewController.m
//  上下文切换
//
//  Created by 解炳灿 on 16/5/5.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView *view = [[CustomView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
