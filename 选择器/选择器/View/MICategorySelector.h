//
//  MICategorySelector.h
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  分类选择器
 */
@interface MICategorySelector : UIView

@property (nonatomic, copy) void(^didAction)(NSInteger index);

+ (MICategorySelector *)defaultSelector:(CGRect)frame titles:(NSArray *)titles;

@end
