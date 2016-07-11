//
//  MICategorySelector.m
//  选择器
//
//  Created by 解炳灿 on 16/5/26.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MICategorySelector.h"

//主题颜色
#define kSelectorSubjectColor [UIColor colorWithRed:54/255.0 green:158/255.0 blue:210/255.0 alpha:1]

static const int kMoveViewHeight = 3;

static const CGFloat kAnimationDuration = 0.3;

@interface MICategorySelector() {
    //自身宽度
    CGFloat _baseWidth;
    //自身高度
    CGFloat _baseHeight;
    //单元宽度
    CGFloat _unitWidth;
    //动画是否在执行
    BOOL _animationRuning;
}

//底部移动线段
@property (nonatomic, strong) UIView *moveView;
//标题数组
@property (nonatomic, strong) NSArray *titles;
//当前位置
@property (nonatomic, assign) NSInteger currentLocation;

@end

@implementation MICategorySelector

#pragma mark 获取实例
+ (MICategorySelector *)defaultSelector:(CGRect)frame titles:(NSArray *)titles {
    
    if (titles == nil || titles.count == 0) {
        return nil;
    }
    
    MICategorySelector *selector = [[MICategorySelector alloc] initWithFrame:frame];
    
    selector.titles = titles;
    
    [selector initView];
    
    [selector setNeedsLayout];
    [selector layoutIfNeeded];
    
    return selector;
}

#pragma mark 创建视图
- (void)initView {
    
    _baseWidth = self.frame.size.width;
    
    _baseHeight = self.frame.size.height;
    
    _unitWidth = _baseWidth / _titles.count;
    
    self.clipsToBounds = NO;
    //1.分割线
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, _baseHeight - 1, _baseWidth, 1)];
    sepLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [self addSubview:sepLine];
    
    //2.底部运动线条
    _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, _baseHeight - kMoveViewHeight, _unitWidth, kMoveViewHeight)];
    _moveView.backgroundColor = kSelectorSubjectColor;
    [self addSubview:_moveView];
    
    //3.标题
    for (NSInteger index = 0; index < _titles.count; index++) {
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(_unitWidth * index, 0, _unitWidth, _baseHeight - kMoveViewHeight)];
        unitLabel.tag = 1000 + index;
        unitLabel.userInteractionEnabled = YES;
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:16];
        unitLabel.text = _titles[index];
        //字体颜色
        if (index) {
            unitLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        }else {
            unitLabel.textColor = kSelectorSubjectColor;
            _currentLocation = index;
        }
        //点击手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [unitLabel addGestureRecognizer:tapGes];
        
        [self addSubview:unitLabel];
    }
}

#pragma mark 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    UILabel *tapView = (UILabel *)tap.view;
    
    NSInteger index = tapView.tag - 1000;
    //点击不是当前单元且不是动画执行中，才响应
    if (index != _currentLocation && !_animationRuning) {
        
        _animationRuning = YES;
        //改变文字颜色
        UILabel *lastSelect = [self viewWithTag:_currentLocation + 1000];
        lastSelect.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        tapView.textColor = kSelectorSubjectColor;
        //执行动画
        [UIView animateWithDuration:kAnimationDuration animations:^{
            CGRect baseFrame = self.moveView.frame;
            baseFrame.origin.x = index * self->_unitWidth;
            self.moveView.frame = baseFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                self->_currentLocation = index;
                self->_animationRuning = NO;
            }
        }];
        //回调
        if (_didAction) {
            _didAction(index);
        }
    }
    
}

#pragma mark 加载标题数组
- (void)loadTitles:(NSArray *)titles frame:(CGRect)frame {
    if (titles == nil || titles.count == 0) {
        return;
    }
    //1.清除视图
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    self.titles = titles;
    
    self.frame = frame;
    
    //2.创建视图
    [self initView];
}

@end
