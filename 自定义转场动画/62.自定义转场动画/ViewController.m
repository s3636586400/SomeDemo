//
//  ViewController.m
//  62.自定义转场动画
//
//  Created by s3636586400 on 16/6/28.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didDidmiss:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
        [_delegate modalViewControllerDidClickedDismissButton:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
