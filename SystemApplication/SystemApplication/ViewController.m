//
//  ViewController.m
//  SystemApplication
//
//  Created by xbc on 16/5/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerDataSource.h"

#import "MessageController.h"

static const NSString *kPhoneNum = @"18652066845";
static const NSString *kEmailAddress = @"15966058154@163.com";
static const NSString *kWebAddress = @"https://www.baidu.com";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) ViewControllerDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModel];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initModel {
    self.dataSource = [[ViewControllerDataSource alloc] initWithController:self];
    self.dataSource.titles = [self getTitles];
    __weak ViewController *weakSelf = self;
    [self.dataSource setSelectBlock:^(NSInteger section, NSInteger row) {
        switch (section) {
            case 0:
                //系统应用分发器
                [weakSelf applicationSwitcher:row];
                break;
            case 1:
                [weakSelf serverSwitcher:row];
                break;
            default:
                break;
        }
    }];
}

- (void)initView {
    self.title = @"System Support";
    
    self.mainTableView.dataSource = self.dataSource;
    self.mainTableView.delegate = self.dataSource;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

- (NSArray *)getTitles {
    NSArray *systemApplicationTitles = @[@"调用电话",
                                         @"调用短信",
                                         @"调用邮件",
                                         @"调用网页"];
    NSArray *systemServerTitles = @[@"调用短信",
                                    @"调用邮件",
                                    @"通讯录"];
    return @[systemApplicationTitles,systemServerTitles];
}

#pragma mark System Application Switcher
- (void)applicationSwitcher:(NSInteger)row {
    switch (row) {
        case 0:
            [self phoneCall];
            break;
        case 1:
            [self sendMessage];
            break;
        case 2:
            [self sendEmail];
            break;
        case 3:
            [self webViewer];
            break;
        default:
            break;
    }
}

#pragma mark System Application
/**
 *  电话
 */
- (void)phoneCall {
    NSString *url = [NSString stringWithFormat:@"telprompt://%@",kPhoneNum];
    [self openUrl:url];
}

/**
 *  短信
 */
- (void)sendMessage {
    NSString *url = [NSString stringWithFormat:@"sms://%@",kPhoneNum];
    [self openUrl:url];
}

/**
 *  邮件
 */
- (void)sendEmail {
    NSString *url = [NSString stringWithFormat:@"mailto://%@",kEmailAddress];
    [self openUrl:url];
}

/**
 *  浏览器
 */
- (void)webViewer {
    [self openUrl:[NSString stringWithFormat:@"%@",kWebAddress]];
}

- (void)openUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    UIApplication *application = [UIApplication sharedApplication];
    if (![application canOpenURL:url]) {
        NSLog(@"无法打开\"%@\"",url);
        return;
    }
    [application openURL:url];
}

#pragma mark System Server Switcher
- (void)serverSwitcher:(NSInteger)row {
    switch (row) {
        case 0:
            [self sendMessageWithSystemController];
            break;
        case 1:
            [self sendEmailWithSystemController];
            break;
        case 2:
            [self addressBook];
            break;
        default:
            break;
    }
}

/**
 *  通过MFMessageComposeViewController发短信
 */
- (void)sendMessageWithSystemController {
    MessageController *messageController = [[MessageController alloc] customInit];
    [self.navigationController pushViewController:messageController animated:YES];
}

/**
 *  通过MFMailComposeViewController发邮件
 */
- (void)sendEmailWithSystemController {
    
}

/**
 *  通讯录
 */
- (void)addressBook {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
