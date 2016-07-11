//
//  ViewControllerDataSource.h
//  SystemApplication
//
//  Created by xbc on 16/5/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerDataSource : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *titles;

@property (copy, nonatomic) void(^selectBlock)(NSInteger section,NSInteger row);

- (instancetype)initWithController:(UIViewController *)controller;

@end
