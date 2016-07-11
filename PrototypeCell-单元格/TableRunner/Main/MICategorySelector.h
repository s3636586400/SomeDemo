//
//  MICategorySelector.h
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDGroupedUnreadCountModel;

/**
 *  分类选择器
 */
@interface MICategorySelector : UIView

@property (nonatomic, copy) void(^didAction)(NSInteger index);

/**
 *  获取实例
 *
 *  @param frame  Frame
 *  @param titles 标题数组
 *
 *  @return 实例
 */
+ (MICategorySelector *)defaultSelector:(CGRect)frame titles:(NSArray *)titles;

/**
 *  加载标题数组
 *
 *  @param titles 标题数组
 *  @param frame  Frame
 */
- (void)loadTitles:(NSArray *)titles frame:(CGRect)frame;

@end
