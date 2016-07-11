//
//  ViewController.m
//  NSURLSession
//
//  Created by 解炳灿 on 16/4/23.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

#define DOWNLOAD_URL [@"https://www.miduo.com/ipadv001/wsa?serType=M001&data={\"vid\":\"1\"}"  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define kBackgroundSessionID @"backgroundsessionid"

@interface ViewController ()<NSURLSessionDelegate>

//View
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *achieveLabel;

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, copy) NSString *achieveStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.session = [self backgroundSession];
    self.progressView.progress = 0.0;
}

- (NSURLSession *)backgroundSession {
    
    static NSURLSession *backgroundSess = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:kBackgroundSessionID];
        backgroundSess = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        backgroundSess.sessionDescription = kBackgroundSessionID;
    });
    
    return backgroundSess;
}

- (IBAction)download:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DOWNLOAD_URL]];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];
    
    self.progressView.hidden = NO;
    self.achieveLabel.hidden = NO;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (downloadTask == self.downloadTask)
    {
        double progress = (double)totalBytesWritten / (double) 241 * 1024 * 1024;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
            NSString *current = [NSString stringWithFormat:@"%.2f",totalBytesWritten / 1024.0 / 1024.0];
            if (self.achieveStr) {
                self.achieveLabel.text = [self.achieveLabel.text stringByReplacingOccurrencesOfString:self.achieveStr withString:current];
            }else {
                self.achieveLabel.text = [self.achieveLabel.text stringByReplacingOccurrencesOfString:@"A" withString:current];
            }
            self.achieveStr = current;
            
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
