//
//  ViewController.m
//  运动事件
//
//  Created by 解炳灿 on 16/5/6.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import "ShakeLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ShakeLabel *shakeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.shakeLabel becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.shakeLabel resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
