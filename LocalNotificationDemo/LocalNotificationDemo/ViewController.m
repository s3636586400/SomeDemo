//
//  ViewController.m
//  LocalNotificationDemo
//
//  Created by 解炳灿 on 16/4/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLocalNotification];
}

- (void)addLocalNotification {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [notification setFireDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    [notification setAlertBody:@"this is an alert"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
