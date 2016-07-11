//
//  ViewController.m
//  CategoryDemo
//
//  Created by 解炳灿 on 16/6/7.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Custom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"Mask";
    str.customDescription = @"CustomMask";
    
    NSLog(@"%@-%@",str,str.customDescription);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
