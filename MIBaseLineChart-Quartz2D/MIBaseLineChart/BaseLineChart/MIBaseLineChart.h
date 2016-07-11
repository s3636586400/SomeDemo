//
//  MIBaseLineChart.h
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseLineChartProtocol <NSObject>

@required
/**
 *  接受要刷新的数据
 *
 *  @param data 当前选中点需要展示的数据
 */
- (void)refreshInfoWithData:(id)data;

@end


@interface MIBaseLineChart : UIView

//选中时展示的该点信息的视图
@property (nonatomic, strong) UIView<BaseLineChartProtocol> *noticeView;

- (instancetype)initWithFrame:(CGRect)frame XMarks:(NSArray *)xMarks YMarks:(NSArray *)yMarks PointValues:(NSArray *)pointValues ;

@end
