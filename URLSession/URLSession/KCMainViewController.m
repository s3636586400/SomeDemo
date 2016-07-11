//
//  KCMainViewController.m
//  URLSession
//
//  Created by Kenshin Cui on 14-03-23.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"
#import "AppDelegate.h"

@interface KCMainViewController ()<NSURLSessionDownloadDelegate>{
    NSURLSessionDownloadTask *_downloadTask;
    NSString *_fileName;
}

@property (nonatomic,strong) UILabel *mainLabel;

@end

@implementation KCMainViewController

#pragma mark - UI方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self downloadFile];
}

- (void)initView {
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    self.mainLabel.center = self.view.center;
    
    [self.view addSubview:self.mainLabel];
}

#pragma mark 取得一个后台会话(保证一个后台会话，这通常很有必要)
-(NSURLSession *)backgroundSession{
    static NSURLSession *session;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cmjstudio.URLSession"];
        sessionConfig.timeoutIntervalForRequest=5.0f;//请求超时时间
        sessionConfig.discretionary=YES;//系统自动选择最佳网络下载
        sessionConfig.HTTPMaximumConnectionsPerHost=5;//限制每次最多一个连接
        //创建会话
        session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];//指定配置和代理
    });
    return session;
}

#pragma mark 文件下载
-(void)downloadFile{
    NSString *urlStr=@"https://www.miduo.com/ipadv001/wsa?serType=M001&data={\"vid\":\"2\"}";
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //后台会话
    _downloadTask=[[self backgroundSession] downloadTaskWithRequest:request];
    
    [_downloadTask resume];
}
#pragma mark - 下载任务代理
#pragma mark 下载中(会多次调用，可以记录下载进度)
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSString *str = [NSString stringWithFormat:@"已下载%.2fM",totalBytesWritten / 1024.0 / 1024.0];
    
    __weak KCMainViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.mainLabel.text = str;
    });

}

#pragma mark 下载完成
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSError *error;
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath=[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSDate date]]];
    NSLog(@"%@",savePath);
    NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error];
    if (error) {
        NSLog(@"didFinishDownloadingToURL:Error is %@",error.localizedDescription);
    }
}

#pragma mark 任务完成，不管是否下载成功
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSString *result = nil;
    if (error) {
        result = @"下载失败";
    }else {
        result = @"下载完成";
    }
    
    __weak KCMainViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf alertString:result];
    });
}

-(void)alertString:(NSString *)str {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

@end
