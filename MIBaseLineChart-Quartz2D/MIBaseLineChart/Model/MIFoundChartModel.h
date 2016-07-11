//
//  MIFoundChartModel.h
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
/**
 *  基金折线图数据模型
 */
@interface MIFoundChartModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *applyState;//选中一个点时，状态1展示字符串

@property (nonatomic, strong) NSString *redeemState;//选中一个点时，状态2展示字符串

@property (nonatomic, strong) NSString *date;//日期

@property (nonatomic, strong) NSNumber *currentValue;//值

@property (nonatomic, strong) NSNumber *totalValue;//累计值

@end
