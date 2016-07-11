//
//  ViewControllerDataSource.m
//  SystemApplication
//
//  Created by xbc on 16/5/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "ViewControllerDataSource.h"

@interface ViewControllerDataSource()

@property (weak, nonatomic) UIViewController *delegate;

@end

@implementation ViewControllerDataSource

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.delegate = controller;
    }
    return self;
}

#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titles[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"System Appliction";
    }else if (section == 1) {
        return @"System Server";
    }else {
        return @"HOHOOHO~";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock) {
        _selectBlock(indexPath.section, indexPath.row);
    }
}


@end
