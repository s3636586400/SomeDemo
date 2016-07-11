//
//  ViewController.m
//  音频
//
//  Created by 解炳灿 on 16/5/10.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)playSoundEffect:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:@"" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID = 0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
