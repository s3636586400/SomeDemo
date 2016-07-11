//
//  ImageViewerController.m
//  AVFoundation拍照和录像
//
//  Created by 解炳灿 on 16/5/11.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ImageViewerController.h"

@interface ImageViewerController ()


@end

@implementation ImageViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
}
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
