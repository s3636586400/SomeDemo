//
//  ViewController.m
//  PickerViewDemo
//
//  Created by xbc on 16/2/27.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "ViewController.h"
#import "MIPickerView.h"

@interface ViewController ()<MIPickerViewDelegate>

@property (nonatomic ,strong) MIPickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initPickerView {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 61; i++) {
        NSString *ageStr = [NSString stringWithFormat:@"%ld岁",i];
        [mutableArray addObject:ageStr];
    }
    NSArray *array = [NSArray arrayWithArray:mutableArray];
    
    _pickerView = [MIPickerView defaultPickerViewWithArray:array delegate:self];
    [self.view addSubview:_pickerView];
}

- (IBAction)addPickerView:(id)sender {
    [self initPickerView];
}

- (void)didClickedWithResultString:(NSString *)resultString {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:resultString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
