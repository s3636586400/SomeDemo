//
//  NSString+Custom.m
//  CategoryDemo
//
//  Created by 解炳灿 on 16/6/7.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import "NSString+Custom.h"
#import <objc/runtime.h>

static NSString * const customKey = @"customKey";

@implementation NSString (Custom)

- (NSString *)customDescription {
    return objc_getAssociatedObject(self, &customKey);
}

- (void)setCustomDescription:(NSString *)customDescription {
    objc_setAssociatedObject(self, &customKey, customDescription, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
