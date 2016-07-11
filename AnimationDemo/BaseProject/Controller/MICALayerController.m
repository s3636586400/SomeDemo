//
//  MIAnchorPointController.m
//  BaseProject
//
//  Created by 解炳灿 on 16/4/22.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MICALayerController.h"

#define LENGTH 50

@interface MICALayerController ()

@end

@implementation MICALayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self custemLayer];
}

- (void)custemLayer {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, LENGTH, LENGTH);
    layer.cornerRadius = LENGTH / 2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    
    [self.view.layer addSublayer:layer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.view.layer.sublayers[0];
    CGFloat width = layer.bounds.size.width;
    if (width == LENGTH) {
        width = LENGTH * 4;
    }else {
        width = LENGTH;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position  = [touch locationInView:self.view];
    layer.cornerRadius = width / 2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
