//
//  ViewController.m
//  SocketServer
//
//  Created by Simple on 13-3-28.
//  Copyright (c) 2013年 simple. All rights reserved.
//

#import "ViewController.h"
#import "SocketConfig.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize listener;
@synthesize message,ReceiveData;
bool isRunning = NO;//判断当前socket是否已经开始监听socket请求

-(void) sendMessage
{
    if(!isRunning)
    {
        NSError *error = nil;
        if (![listener acceptOnPort:_SERVER_PORT_ error:&error]) {
            return;
        }
        NSLog(@"开始监听");
        isRunning = YES;
    }
    else
    {
        NSLog(@"重新监听");
        [listener disconnect];
        for (int i = 0; i < [connectionSockets count]; i++) {
            [[connectionSockets objectAtIndex:i] disconnect];
        }
        isRunning = FALSE;
    }
}
- (IBAction)sendMessage:(id)sender
{
    if(![message.text isEqual:@""])
    {
        [listener writeData:[message.text dataUsingEncoding:NSUTF8StringEncoding]
                withTimeout:-1 tag:1];
    }
    else
    {
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Waring" message:@"Please Input Message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        [alertView release];
    }
}
- (IBAction)textEndEditting:(id)sender
{
    [message resignFirstResponder];
}
- (void)viewDidLoad
{
    ReceiveData.editable=NO;//设置TextView不可以编辑
    listener=[[AsyncSocket alloc] initWithDelegate:self];
    message.delegate=self;
    //初始化连接socket的个数
    connectionSockets=[[NSMutableArray alloc] initWithCapacity:30];
    [self sendMessage];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

#pragma socket委托
//连接socket出错时调用
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"%@",[err description]);
}
//收到新的socket连接时调用
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    [connectionSockets addObject:newSocket];
    
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //[sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];  // 这句话仅仅接收\r\n的数据
    
    [sock readDataWithTimeout: -1 tag: 0];
}
//与服务器建立连接时调用(连接成功)
- (void) onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"host:%@",host);
    NSString *returnMessage=@"Welcome To Socket Test Server!";
    //将NSString转换成为NSData类型
    NSData *data=[returnMessage dataUsingEncoding:NSUTF8StringEncoding];
    //向当前连接服务器的客户端发送连接成功信息
    [sock writeData:data withTimeout:-1 tag:0];
}
/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
 读取客户端发送来的信息(收到socket信息时调用)
 **/
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
//    NSLog(@"%@",[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
//    [sock writeData:data withTimeout:-1 tag:1];
    NSString *msg = [[[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding] autorelease];
    //获取当前发送消息的客户端ip
    //NSLog(@"%@",sock.connectedHost);
    //NSString *ClientIp=[sock connectedHost];
    NSString *receviceIp=nil;
    for(int i=0;i<[connectionSockets count];i++)
    {
        AsyncSocket *s=(AsyncSocket*)[connectionSockets objectAtIndex:i];
//        NSRange range=[msg rangeOfString:@":"];
        if([sock.connectedHost isEqualToString:@"10.0.73.252"])
        {receviceIp=@"10.0.73.251";}
        else
        {receviceIp=@"10.0.73.252";}
        if([s.connectedHost isEqualToString:receviceIp])
        {
            [s writeData:data withTimeout:-1 tag:0];
            if(msg)
            {
                ReceiveData.text = msg;
                NSLog(@"message--->收到---%@",msg);
            }
            else
            {
                NSLog(@"Error converting received data into UTF-8 String");
            }
        }
        else
        {
            NSString *returnMes=@"对方不在线!";
            NSData *datareturn=[returnMes dataUsingEncoding:NSUTF8StringEncoding];
            [sock writeData:datareturn withTimeout:-1 tag:0];
        }
    }
    
    
    // Even if we were unable to write the incoming data to the log,
    // we're still going to echo it back to the client.
    //[sock writeData:data withTimeout:-1 tag:1];

}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    [connectionSockets removeObject:sock];
}

#pragma end Deleagte

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [ReceiveData release],ReceiveData=nil;
    [message release], message=nil;
    [listener release];
    [ReceiveData release];
    [super dealloc];
}
@end
