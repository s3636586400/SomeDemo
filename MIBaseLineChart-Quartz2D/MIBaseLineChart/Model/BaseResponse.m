//
//  BaseResponse.m
//  FinancialManageClient
//
//  Created by 金考网 on 14-12-28.
//  Copyright (c) 2014年 MIDUO. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return dateFormatter;
}
+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *str) {
        if(str==nil)
            return @"";
        return  str;
    } ];
}

@end
