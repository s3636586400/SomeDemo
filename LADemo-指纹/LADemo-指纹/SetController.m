//
//  SetController.m
//  LADemo-指纹
//
//  Created by 解炳灿 on 16/5/13.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "SetController.h"

#import <LocalAuthentication/LocalAuthentication.h>

#import "MainViewController.h"

@interface SetController ()

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self authentication];
}

- (void)authentication {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *authError = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        NSString *msg = @"请验证指纹";
        
        __weak SetController *weakSelf = self;
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:msg reply:^(BOOL success, NSError * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    //验证成功
                    MainViewController *mainVC = [[MainViewController alloc] init];
                    [weakSelf presentViewController:mainVC animated:YES completion:nil];
                }else {
                    NSString *str = nil;
                    switch (error.code) {
                        case LAErrorUserCancel:
                            str = @"用户取消了授权";
                            NSLog(@"用户取消了授权");
                            break;
                        case LAErrorUserFallback:
                            str = @"并又没用";
                            NSLog(@"用户点击了输入密码");
                            break;
                        case LAErrorAuthenticationFailed:
                            str = @"您已授权失败3次";
                            NSLog(@"您已授权失败3次");
                            break;
                        case LAErrorTouchIDLockout:
                            str = @"指纹被锁定";
                            NSLog(@"指纹被锁定");
                            break;
                        case LAErrorSystemCancel:
                            str = @"App进入后台";
                            NSLog(@"应用程序进入后台");
                            break;
                        default:
                            str = @"其他错误";
                            NSLog(@"%@",[error localizedDescription]);
                            break;
                    }
                    NSString *fullStr = [NSString stringWithFormat:@"%@，3秒后退出程序",str];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:fullStr delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alertView show];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(-1);
                    });
                    
                }
            });
        }];
    }else {
        switch (authError.code) {
            case LAErrorPasscodeNotSet:
                NSLog(@"未设置密码:%@",[authError localizedDescription]);
                break;
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"该设备不支持TouchID:%@",[authError localizedDescription]);
                break;
            default:
                NSLog(@"%@",[authError localizedDescription]);
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
