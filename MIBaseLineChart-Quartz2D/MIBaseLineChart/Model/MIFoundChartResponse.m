//
//  MIFoundChartResponse.m
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "MIFoundChartResponse.h"
#import "MIFoundChartModel.h"

@implementation MIFoundChartResponse

@dynamic data;

+(NSValueTransformer*)dataJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[MIFoundChartModel class]];
}

@end
