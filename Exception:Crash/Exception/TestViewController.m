//
//  TestViewController.m
//  Exception
//
//  Created by 解炳灿 on 16/4/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)click:(id)sender {
    [self crashTest];
}

- (void)crashTest {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSString *value = nil;
    [mutableArray addObject:value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
