
//
//  TimerViewController.m
//  GCD定时器
//
//  Created by 解炳灿 on 16/5/25.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "TimerViewController.h"

#define VERIFY_TIMEOUT 10

@interface TimerViewController () {
    NSInteger _counter;
}

@property (nonatomic, strong) UIButton *mainButton;

//@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self initTimer];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];

    self.mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mainButton.backgroundColor = [UIColor lightGrayColor];
    [_mainButton setTitle:@"Start" forState:UIControlStateNormal];
    [_mainButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _mainButton.frame = CGRectMake(0, 0, 200, 40);
    _mainButton.center = self.view.center;
    [self.view addSubview:_mainButton];
    
}

- (void)click:(UIButton *)button {
    _counter = VERIFY_TIMEOUT;
    button.enabled = NO;
    [self initTimer];
}

- (void)initTimer {
    
    __weak TimerViewController *weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"ALIVE...");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_counter <= 0) {
                //倒计时结束
                [weakSelf.mainButton setTitle:@"Start" forState:UIControlStateNormal];
                weakSelf.mainButton.enabled = YES;
                dispatch_source_cancel(timer);
                NSLog(@"KILL...");
            }else {
                [weakSelf.mainButton setTitle:[NSString stringWithFormat:@"%ld",_counter] forState:UIControlStateNormal];
                _counter = _counter - 1;
            }
        });
    });
    dispatch_resume(timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
