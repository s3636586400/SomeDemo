//
//  ShakeLabel.m
//  运动事件
//
//  Created by 解炳灿 on 16/5/6.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ShakeLabel.h"

@implementation ShakeLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textAlignment = NSTextAlignmentCenter;
    self.text = [self getRandomNumber];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.text = [self getRandomNumber];
    }
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}


- (NSString *)getRandomNumber {
    int num = arc4random() % 6;
    NSString *str = [[NSString alloc] initWithFormat:@"%d",num + 1];
    return str;
}

@end
