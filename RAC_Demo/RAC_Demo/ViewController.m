//
//  ViewController.m
//  RAC_Demo
//
//  Created by 解炳灿 on 16/4/19.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self RACTest];
    [self RACAnother];
}

- (void)RACTest {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"first - %@",x);
    }];
    
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"second - %@",x);
    }];
}

- (void)RACAnother {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
