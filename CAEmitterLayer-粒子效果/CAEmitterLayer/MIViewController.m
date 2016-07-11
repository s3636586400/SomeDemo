//
//  MIViewController.m
//  CAEmitterLayer
//
//  Created by s3636586400 on 16/6/13.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import "MIViewController.h"

@interface MIViewController ()

@end

@implementation MIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)startUp {
    CAEmitterCell *emitter = [CAEmitterCell emitterCell];
    
    emitter.contents = [UIImage imageNamed:@"Like-Sparkle"];
    emitter.name = @"explosion";
    emitter.alphaRange = 0.2f;
    emitter.alphaSpeed = -1.f;
    emitter.lifetime = 0.7f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
