//
//  ViewController.m
//  属性测试
//
//  Created by 解炳灿 on 16/5/25.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    int _count;
    NSString *_subStr;
}

struct book {
    struct book * nextBook;
    int bookID;
};

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%p",&_count);
    NSLog(@"%d",_count);
    NSLog(@"%d",self->_count);
    
    NSLog(@"***********************");
    
    _subStr = @"LOLOLO";
    NSLog(@"%p",&_subStr);
    NSLog(@"%@",_subStr);
    NSLog(@"%@",self->_subStr);
    
    NSLog(@"***********************");

    struct book myBook1 = {
        NULL,
        1001
    };
    struct book myBook2 = {
        &myBook1,
        1002
    };
    
    NSLog(@"%p",&myBook2.nextBook);
    NSLog(@"%p",&myBook1);
    NSLog(@"%d",myBook2.nextBook->bookID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
