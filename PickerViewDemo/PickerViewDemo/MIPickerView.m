//
//  MIPickerView.m
//  PickerViewDemo
//
//  Created by xbc on 16/2/27.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "MIPickerView.h"

@interface MIPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

//Delegate
@property (nonatomic,weak) id<MIPickerViewDelegate> delegate;
//Data
@property (nonatomic,strong) NSArray *dataArray;
//Views
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIView *pickerBar;

@property (weak, nonatomic) IBOutlet UIButton *maskBtn;

@property (weak, nonatomic) IBOutlet UIImageView *cancelImageView;

@property (weak, nonatomic) IBOutlet UIImageView *confirmImageView;

@end

@implementation MIPickerView

+ (MIPickerView *)defaultPickerViewWithArray:(NSArray *)array delegate:(id<MIPickerViewDelegate>)delegate {
    MIPickerView *picker = [[[NSBundle mainBundle] loadNibNamed:@"MIPickerView" owner:nil options:nil] firstObject];
    
    picker.frame = [UIScreen mainScreen].bounds;
    
    [picker setData:array delegate:delegate];
    
    return picker;
}

- (void)setData:(NSArray *)dataArray delegate:(id<MIPickerViewDelegate>)delegate {
    self.delegate = delegate;
    self.dataArray = dataArray;
    //set pickerView
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

- (IBAction)Cancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)Confirm:(id)sender {
    if (_delegate!= nil && [_delegate respondsToSelector:@selector(didClickedWithResultString:)]) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        
        NSString *resultString = nil;
        if (_dataArray.count > index) {
            resultString = _dataArray[index];
        }
        [_delegate didClickedWithResultString:resultString];
    }
    [self removeFromSuperview];
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

#pragma mark UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 34.0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *baseStr = nil;
    if (_dataArray!=nil && (_dataArray.count > row)) {
        baseStr = _dataArray[row];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:baseStr];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, baseStr.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] range:NSMakeRange(0, baseStr.length)];
        
        return attributeString;
    }else {
        return nil;
    }
}

#pragma mark overwrite setter
- (void)setPickerBackgroundColor:(UIColor *)pickerBackgroundColor {
    _pickerBackgroundColor = pickerBackgroundColor;
    
    _pickerView.backgroundColor = _pickerBackgroundColor;
}

- (void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor {
    _maskBackgroundColor = maskBackgroundColor;
    
    _maskBtn.backgroundColor = _maskBackgroundColor;
}

- (void)setPickerBarBackgroundColor:(UIColor *)pickerBarBackgroundColor {
    _pickerBackgroundColor = pickerBarBackgroundColor;
    
    _pickerBar.backgroundColor = _pickerBarBackgroundColor;
}

- (void)setCancelImage:(UIImage *)cancelImage {
    _cancelImage = cancelImage;
    
    _cancelImageView.image = _cancelImage;
}

- (void)setConfirmImage:(UIImage *)confirmImage {
    _confirmImage = confirmImage;
    
    _confirmImageView.image = _confirmImage;
}

#pragma mark overwrite getter

@end
