//
//  ViewController.m
//  位运算
//
//  Created by s3636586400 on 16/6/15.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //&按位与
    //|按位或
    //~按位异或
    //^取反
    //这四个都确定了。<< >>补位不确定，试下：
    
    //左移<<
    //右侧补0，等价于乘2
    for (int i = 0; i < 5; i++) {
        int x = 1 << i;
        printf("1 << %d = %d\n", i, x);
    }
    printSepLine();
    
    //右移
    //左侧补0，符号位不变，相当于除2
    for (int i = 0; i < 5; i++) {
        int x = 32 >> i;
        printf("32 >> %d = %d\n", i, x);
    }
    printf("\n");
    for (int i = 0; i < 5; i++) {
        int x = (-32) >> i;
        printf("-32 >> %d = %d\n", i, x);
    }
    printSepLine();
    int size = sizeof(NSUInteger);
    printf("NSUInteger size: %d",size);
    
    printSepLine();
    for (NSUInteger i = 0; i < 12; i++) {
        NSUInteger targetValue = 1 << 0;
        NSUInteger loopValue = 1 << i;
        printf("Index:%ld %s\n", i, targetValue|loopValue?"true":"false");
    }

    
}

void printSepLine()
{
    for (int i = 0; i < 7; i++) {
        printf("✨");
    }
    printf("\n");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
