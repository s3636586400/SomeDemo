//
//  MessageController.m
//  SystemApplication
//
//  Created by 解炳灿 on 16/5/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "MessageController.h"
#import <MessageUI/MessageUI.h>

static const NSString * kStoryboardID = @"messageConroller";

@interface MessageController ()<MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) MFMessageComposeViewController *messageController;

//View
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *receiverTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
//Cons
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;

@end

@implementation MessageController

- (MessageController *)customInit {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MessageController *instance = [storyboard instantiateViewControllerWithIdentifier:(NSString *)kStoryboardID];
    
    return instance;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新信息";
    
    [self addNotification];
    
    [self.receiverTextField becomeFirstResponder];
    
}

/**
 *  添加键盘通知
 */
- (void)addNotification {
    //出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/**
 *  接受通知，由键盘高度改变输入框位置
 */
- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    
    self.bottomCons.constant = keyboardRect.size.height;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
}

/**
 *  接受通知，键盘隐藏时调整输入框
 */
- (void)keyboardWillHide:(NSNotification *)noti {
    self.bottomCons.constant = 0;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (IBAction)messageChanged:(UITextField *)sender {
    if (sender.text.length) {
        self.sendButton.hidden = NO;
    }else {
        self.sendButton.hidden = YES;
    }
}


/**
 *  发送短信
 */
- (IBAction)sendMessage:(UIButton *)sender {
    if ([MFMessageComposeViewController canSendText]) {
        self.messageController = [[MFMessageComposeViewController alloc] init];
        //收件人
        self.messageController.recipients = [self.receiverTextField.text componentsSeparatedByString:@","];
        //信息正文
        self.messageController.body = self.messageTextField.text;
        //代理
        self.messageController.messageComposeDelegate = self;
        //主题、附件用到再查吧……
        
        [self presentViewController:self.messageController animated:YES completion:nil];
    }
}

#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MessageComposeResultSent:
            NSLog(@"已发送");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        default:
            break;
    }
    [self.messageController dismissViewControllerAnimated:YES completion:nil];
}



-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
