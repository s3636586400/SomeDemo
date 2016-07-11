//
//  ViewController.m
//  Client
//
//  Created by 解炳灿 on 16/4/12.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ViewController ()

//Views
@property (weak, nonatomic) IBOutlet UILabel *serverIP;

@property (weak, nonatomic) IBOutlet UITextView *mainTextField;

@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@property (nonatomic, strong) AsyncSocket *clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.serverIP.text = HOST;
    
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    
    [self connectToServer];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable=YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar =NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
}

/**
 *  连接到Server
 */
- (void)connectToServer {
    
    NSError *error = nil;
    if ([self.clientSocket connectToHost:HOST onPort:PORT withTimeout:3 error:&error]) {
        NSLog(@"已连接");
    }else {
        NSLog(@"连接失败.%@",[error localizedDescription]);
    }
}

/**
 *  发送消息到Server
 */
- (IBAction)send:(UIButton *)sender {
    if (!self.inputTF.text.length) {
        return;
    }
    NSString *fullStr= self.inputTF.text;
    [self.clientSocket writeData:[fullStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:20 tag:0];
}

#pragma mark AsyncSocketDelegate

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu",sock,host,port);
    [sock readDataWithTimeout:1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *reciveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.mainTextField.text = reciveStr;
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"onSocketDidDisconnect:%p", sock);
    NSString *msg = @"Sorry this connect is failure";
    self.mainTextField.text = msg;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
