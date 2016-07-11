//
//  BaseResponse.h
//  FinancialManageClient
//
//  Created by 金考网 on 14-12-28.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface BaseResponse : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong)id    data;
@property (nonatomic, assign) int state;
@property (nonatomic,strong)NSString    *msg;

+ (NSDateFormatter *)dateFormatter;
@end
