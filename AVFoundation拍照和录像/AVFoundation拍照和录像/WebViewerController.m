//
//  WebViewerController.m
//  CustomCamera
//
//  Created by 解炳灿 on 16/5/11.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "WebViewerController.h"

@interface WebViewerController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UIWebView居然能直接加载NSData……但是这样加载的图片最下方多了条白线……
    [self.webView loadData:self.data MIMEType:@"image/jpeg" textEncodingName:nil baseURL:nil];
    [self.webView setScalesPageToFit:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
