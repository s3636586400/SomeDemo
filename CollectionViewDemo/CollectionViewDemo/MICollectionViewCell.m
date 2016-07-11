//
//  MICollectionViewCell.m
//  CollectionViewDemo
//
//  Created by 解炳灿 on 16/4/14.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MICollectionViewCell.h"

@implementation MICollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1;
}

@end
