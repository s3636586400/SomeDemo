//
//  ViewController.m
//  SocketClient
//
//  Created by Simple on 13-4-2.
//  Copyright (c) 2013年 simple. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    _clientIPAddress.delegate=self;
    [_clientIPAddress setTag:1];
    _SendMessage.delegate=self;
    [_SendMessage setTag:2];
    _ReceiveData.editable=NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField tag]==2)
    {
        [self viewUp];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
    if([textField tag]==2)
    {
        [self viewDown];
    }
    return YES;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Send:(id)sender {
    if(![_SendMessage.text isEqualToString:@""] && ![_clientIPAddress.text isEqualToString:@""])
    {
        NSString *message=[NSString stringWithFormat:@"%@:%@",_clientIPAddress.text,_SendMessage.text];
        if(socket==nil)
        {
            socket=[[AsyncSocket alloc] initWithDelegate:self];
        }
        //NSString *content=[message stringByAppendingString:@"\r\n"];
        [socket writeData:[message dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        _ReceiveData.text=[NSString stringWithFormat:@"me:%@",_SendMessage.text];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Waring" message:@"Please input Message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)ConnectToSever:(id)sender {
    if(socket==nil)
    {
        socket=[[AsyncSocket alloc] initWithDelegate:self];
        NSError *error=nil;
        if(![socket connectToHost:_IP_ADDRESS_V4_ onPort:_SERVER_PORT_ error:&error])
        {
           _Status.text=@"连接服务器失败!";
        }
        else
        {
            _Status.text=@"已连接!";
        }
    }
    else
    {
        _Status.text=@"已连接!";
    }
}

#pragma AsyncScoket Delagate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu",sock,host,port);
    [sock readDataWithTimeout:1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];  // 这句话仅仅接收\r\n的数据
    
    [sock readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Hava received datas is :%@",aStr);
    self.ReceiveData.text = aStr;
    [aStr release];
    [socket readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    //断开连接了
    NSLog(@"onSocketDidDisconnect:%p", sock);
    NSString *msg = @"Sorry this connect is failure";
    _Status.text=msg;
    [msg release];
    socket = nil;
}
- (void) viewUp
{
    CGRect frame=self.view.frame;
    frame.origin.y=frame.origin.y-215;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame=frame;
    [UIView commitAnimations];
}
- (void) viewDown
{
    CGRect frame=self.view.frame;
    frame.origin.y=frame.origin.y+215;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame=frame;
    [UIView commitAnimations];
}
#pragma end Delegate
- (void)dealloc {
    [_ReceiveData release];
    [_SendMessage release];
    [_Status release];
    [_clientIPAddress release];
    [super dealloc];
}

@end
