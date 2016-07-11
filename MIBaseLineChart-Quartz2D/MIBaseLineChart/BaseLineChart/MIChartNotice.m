//
//  MIChartNotice.m
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "MIChartNotice.h"

@interface MIChartNotice()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation MIChartNotice

+ (MIChartNotice *)defaultChartNotice {
    MIChartNotice *chartNotice = [[[NSBundle mainBundle] loadNibNamed:@"MIChartNotice" owner:nil options:nil] firstObject];

    return chartNotice;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self custemSet];
}

- (void)custemSet {
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1].CGColor;
}

- (void)refreshInfoWithData:(id)data {
    NSString *valueStr = data;
    _valueLabel.text = valueStr;
    [_valueLabel sizeToFit];
    
    CGFloat titleLabelWidth = _titleLabel.frame.size.width;
    CGFloat valueLabelWidth = _valueLabel.frame.size.width;
    CGFloat maxWidth = titleLabelWidth > valueLabelWidth ? titleLabelWidth : valueLabelWidth;
    
    //调整视图的宽度
    CGRect orginFrame = self.frame;
    orginFrame.size.width = maxWidth + 20;
    self.frame = orginFrame;
    
}

@end
