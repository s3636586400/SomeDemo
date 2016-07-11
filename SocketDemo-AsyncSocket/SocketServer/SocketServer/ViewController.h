//
//  ViewController.h
//  SocketServer
//
//  Created by Simple on 13-3-28.
//  Copyright (c) 2013年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"

@interface ViewController : UIViewController<AsyncSocketDelegate,UITextFieldDelegate>
{
    AsyncSocket *listener;//监听客户端请求
    //AsyncUdpSocket *udpSocket;//不需要即时连接就能通讯
    NSMutableArray *connectionSockets;//当前请求连接的客户端
    
    IBOutlet UITextView *ReceiveData;
    IBOutlet UITextField *message;
}

@property (nonatomic, retain)AsyncSocket *listener;
@property (nonatomic, retain)UITextField *message;
@property (nonatomic, retain)UITextView *ReceiveData;


- (IBAction)sendMessage:(id)sender;
- (IBAction)textEndEditting:(id)sender;
@end
