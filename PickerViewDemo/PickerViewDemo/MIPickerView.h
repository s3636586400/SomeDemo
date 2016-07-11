//
//  MIPickerView.h
//  PickerViewDemo
//
//  Created by xbc on 16/2/27.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MIPickerViewDelegate <NSObject>

@required
/**
 *  确认按钮（右侧按钮）点击回调方法
 *
 *  @param resultString picker当前选中的值
 */
- (void)didClickedWithResultString:(NSString *)resultString;

@end

@interface MIPickerView : UIView

+ (MIPickerView *)defaultPickerViewWithArray:(NSArray *)array delegate:(id<MIPickerViewDelegate>)delegate;

/**
 *  picker背景色
 */
@property (nonatomic,strong) UIColor *pickerBackgroundColor;
/**
 *  遮罩层背景色
 */
@property (nonatomic,strong) UIColor *maskBackgroundColor;
/**
 *  picker上方按钮栏的背景色
 */
@property (nonatomic,strong) UIColor *pickerBarBackgroundColor;
/**
 *  取消按钮图片
 */
@property (nonatomic,strong) UIImage *cancelImage;
/**
 *  确认按钮图片
 */
@property (nonatomic,strong) UIImage *confirmImage;

@end
