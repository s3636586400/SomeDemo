//
//  MIProductTrendsCell.m
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIProductTrendsCell.h"

@interface MIProductTrendsCell()

//图标
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//详情
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation MIProductTrendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
