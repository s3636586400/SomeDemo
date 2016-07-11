//
//  MIBaseLineChart.m
//  MIBaseLineChart
//
//  Created by xbc on 16/3/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "MIBaseLineChart.h"

//x轴标注高度
#define XMARK_HEIGHT 15;
//y轴标注宽度
#define YMARK_WIDTH 29;
//背景线颜色
#define BACKGROUND_LINE_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor
//折线颜色
#define LINE_COLOR [UIColor colorWithRed:46/255.0 green:167/255.0 blue:223/255.0 alpha:1.0].CGColor
//是否要闭合背景线
#define NEED_CLOSE YES
//默认是否画点
#define DEFAULT_DRAW_POINT YES
//默认点的半径
#define DEFAULT_POINT_RADIUS 2.5
//Y轴和Y轴标注的间距
#define YMARK_Y_MAGIN 15

@interface MIBaseLineChart() {
    
    CGFloat fullWidth;//折线图宽度
    CGFloat fullHeight;//折线图高度
    
    NSInteger xCount;//X轴共有几个点
    NSInteger yCount;//Y轴被分为几段
    
    CGFloat xMarkHeight;//x轴标注高度
    CGFloat yMarkWidth;//y轴标注宽度
    
    CGFloat unitWidth;//X轴间距
    CGFloat unitHeight;//Y轴间距
    
    CGFloat yMax;//y轴最大值
    CGFloat yMin;//y轴最小值
    
    CGFloat yScaleValue;//比例尺-折线图一个点对应的Y轴大小
    
    CGFloat xZero;//X轴原点
    CGFloat yZero;//Y轴原点
    
    BOOL shouldDrawPoint;//是否要画出点
    CGFloat pointRadius;//点半径
    
    BOOL hideXMarks;//是否要隐藏X轴标注（取决于能否摆开）
    BOOL hideYMarks;//是否要隐藏Y轴标注（取决于能否摆开）
    
    UILabel *lastSelectedXMark;//前一个被选中的X轴标注
}

@property (strong, nonatomic) NSArray *XMarks;//X标注数组

@property (strong, nonatomic) NSArray *YMarks;//Y标注数组

@property (strong, nonatomic) NSArray *pointValues;//每个点值

@property (strong, nonatomic) NSMutableArray *xMarkViews;//x标注视图数组

@property (strong, nonatomic) NSMutableArray *yMarkViews;//y标注视图数组

@property (strong, nonatomic) UIImageView *touchImageView;//选中时的标明线

@end

@implementation MIBaseLineChart


- (instancetype)initWithFrame:(CGRect)frame XMarks:(NSArray *)xMarks YMarks:(NSArray *)yMarks PointValues:(NSArray *)pointValues {
    if (self = [super initWithFrame:frame]) {
        _XMarks = xMarks;
        _YMarks = yMarks;
        _pointValues = pointValues;
        self.backgroundColor = [UIColor whiteColor];
        [self setLineChart];
    }
    return self;
}

- (void)setLineChart {
    //折线图整体宽高
    fullWidth = self.frame.size.width;
    fullHeight = self.frame.size.height;
    
    //X、Y标注数量
    xCount = _XMarks.count;
    yCount = _YMarks.count;
    
    //留给标注的宽高
    xMarkHeight = XMARK_HEIGHT;//X轴标注的高度
    yMarkWidth = YMARK_WIDTH;//Y轴标注的宽度
    
    //X、Y轴标注之间距离(1是坐标轴的高度)
    unitWidth = (fullWidth - yMarkWidth - 1) / (xCount - 1);
    unitHeight = (fullHeight - xMarkHeight - 1) / (yCount - 1);
    
    //Y轴最大值
    yMax = [[_YMarks lastObject] doubleValue];
    //Y轴最小值
    yMin = [[_YMarks firstObject] doubleValue];
  
    //y比例尺
    yScaleValue = (yMax - yMin) / (fullHeight - xMarkHeight - DEFAULT_POINT_RADIUS);
    
    //原点坐标
    xZero = YMARK_WIDTH;
    yZero = fullHeight - XMARK_HEIGHT;
    
    //是否画点
    shouldDrawPoint = DEFAULT_DRAW_POINT;
    //点半径
    pointRadius = DEFAULT_POINT_RADIUS;
    
}

#pragma mark drawRect
- (void)drawRect:(CGRect)rect {
    [self drawBackgroundLine];
    [self drawFillColor];
    [self drawLine];
    [self drawPoint];
    [self refreshMarks];
}
/**
 *  画背景线
 */
- (void)drawBackgroundLine {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //背景色
    CGContextSetStrokeColorWithColor(ctx, BACKGROUND_LINE_COLOR);
    //画Y轴
    CGContextSetLineWidth(ctx, 1);
    CGContextMoveToPoint(ctx, xZero, yZero);
    CGContextAddLineToPoint(ctx, xZero, 0);
    CGContextStrokePath(ctx);
    //画X轴以及横线
    for (NSInteger index = 0; index < yCount; index++) {
        CGContextMoveToPoint(ctx, xZero, yZero - index * unitHeight);
        CGContextAddLineToPoint(ctx, fullWidth, yZero - index * unitHeight);
        CGContextStrokePath(ctx);
    }
    if (NEED_CLOSE) {
        CGContextMoveToPoint(ctx, fullWidth, yZero);
        CGContextAddLineToPoint(ctx, fullWidth, 0);
        CGContextStrokePath(ctx);
    }
}
/**
 *  画折线
 */
- (void)drawLine {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, LINE_COLOR);
    for (NSInteger index = 0; index < _pointValues.count; index++) {
        CGFloat pointValue = [_pointValues[index] doubleValue];
        CGFloat yZeroValue = [[_YMarks firstObject] doubleValue];
        CGFloat y = yZero - (pointValue - yZeroValue) / yScaleValue;
        CGFloat x = xZero + index * unitWidth;
        
        if (index) {
            CGContextAddLineToPoint(ctx, x, y);
        }else {
            CGContextMoveToPoint(ctx, x, y);
        }
    }
    CGContextStrokePath(ctx);
}
/**
 *  画点
 */
- (void)drawPoint {
    if (!DEFAULT_DRAW_POINT) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, LINE_COLOR);
    for (NSInteger index = 0; index < _pointValues.count; index++) {
        CGFloat pointValue = [_pointValues[index] doubleValue];
        CGFloat yZeroValue = [[_YMarks firstObject] doubleValue];
        CGFloat y = yZero - (pointValue - yZeroValue) / yScaleValue;
        CGFloat x = xZero + index * unitWidth;
        
        CGContextAddEllipseInRect(ctx, CGRectMake(x-pointRadius, y-pointRadius, pointRadius * 2, pointRadius * 2));
        CGContextFillPath(ctx);
    }
}
/**
 *  画渐变色
 */
- (void)drawFillColor {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, xZero, yZero);//原点出发
    //折线
    for (NSInteger index = 0; index < _pointValues.count; index++) {
        CGFloat pointValue = [_pointValues[index] doubleValue];
        CGFloat yZeroValue = [[_YMarks firstObject] doubleValue];
        CGFloat y = yZero - (pointValue - yZeroValue) / yScaleValue;
        CGFloat x = xZero + index * unitWidth;
        CGContextAddLineToPoint(ctx, x, y);
    }
    //画完最后一个点回到X轴
    CGContextAddLineToPoint(ctx, fullWidth, yZero);
    CGContextClosePath(ctx);
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    [self fillColor:ctx];
    CGContextRestoreGState(ctx);
}
/**
 *  渐变色
 *
 *  @param ctx CGContextRef
 */
- (void)fillColor:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor colorWithRed:181/255.0 green:223/255.0 blue:242/255.0 alpha:0.8];
    CGFloat *startC = (CGFloat *)CGColorGetComponents(startColor.CGColor);
    UIColor *endColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    CGFloat *endC = (CGFloat *)CGColorGetComponents(endColor.CGColor);
    CGFloat compoents[8] = {
        startC[0],
        startC[1],
        startC[2],
        startC[3],
        endC[0],
        endC[1],
        endC[2],
        endC[3]
    };
    CGFloat colorIndices[2] = {0.0f,1.0f};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&compoents, colorIndices, 2);
    CGColorSpaceRelease(colorSpace);
    CGPoint startPoint ,endPoint;
    startPoint = CGPointMake(fullWidth/2, fullHeight - 335/2);
    endPoint = CGPointMake(fullWidth/2, fullHeight);
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    CGContextRestoreGState(ctx);
}

/**
 *  刷新X、Y标注视图
 */
- (void)refreshMarks {
    //X标注
    for (UIView *xMarkView in self.xMarkViews) {
        //移除旧标注
        [xMarkView removeFromSuperview];
    }
    for (NSInteger index = 0; index < xCount; index++) {
        NSString *markStr = _XMarks[index];//标注字符串
        //标注Label
        UILabel *xmarkView = [[UILabel alloc] init];
        xmarkView.font = [UIFont systemFontOfSize:10];
        xmarkView.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        xmarkView.text = markStr;
        [xmarkView sizeToFit];
        
        //设置位置
        xmarkView.center = CGPointMake(xZero + unitWidth * index, fullHeight - xmarkView.frame.size.height / 2);
        [_xMarkViews addObject:xmarkView];
        if ((xmarkView.frame.size.width + 5) * xCount > fullWidth ) {
            //X标注排不开，不添加X标注了
            hideXMarks = YES;
            continue;
        }
        [self addSubview:xmarkView];
    }
    
    //Y标注
    for (UIView *yMarkView in self.yMarkViews) {
        //移除旧标注
        [yMarkView removeFromSuperview];
    }
    for (NSInteger index = 0; index < yCount; index++) {
        NSString *markStr = _YMarks[index];//标注字符串
        //标注Label
        UILabel *ymarkView = [[UILabel alloc] init];
        ymarkView.font = [UIFont systemFontOfSize:10];
        ymarkView.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        ymarkView.text = markStr;
        [ymarkView sizeToFit];
        
        //设置位置
        ymarkView.center = CGPointMake(xZero - YMARK_Y_MAGIN - ymarkView.frame.size.width / 2, yZero - index * unitHeight);
        [_yMarkViews addObject:ymarkView];
        
        if ((ymarkView.frame.size.height + 5) * yCount > fullHeight) {
            //Y标注排不开，不添加Y标注了
            hideYMarks = YES;
            continue;
        }
        [self addSubview:ymarkView];
    }
}
#pragma mark Getter
- (UIImageView *)touchImageView {
    if (_touchImageView==nil) {
        UIImage *image = [UIImage imageNamed:@"selectLine"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        _touchImageView = [[UIImageView alloc] initWithImage:image];
    }
    
    return _touchImageView;
}

- (NSMutableArray *)xMarkViews {
    if (_xMarkViews == nil) {
        _xMarkViews = [[NSMutableArray alloc] init];
    }
    return _xMarkViews;
}

- (NSMutableArray *)yMarkViews {
    if (_yMarkViews == nil) {
        _yMarkViews = [[NSMutableArray alloc] init];
    }
    return _yMarkViews;
}

#pragma mark Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];
    CGPoint location = [touch locationInView:self];
    //获取位置当前对应的折线点
    NSInteger index = location.x / unitWidth;//该位置对应第index个点
    if (index < 0 || index >= xCount) {
        //越界，停止
        return;
    }
    //获取改点的坐标
    CGFloat pointValue = [_pointValues[index] doubleValue];
    CGFloat yZeroValue = [[_YMarks firstObject] doubleValue];
    CGFloat y = yZero - (pointValue - yZeroValue) / yScaleValue;
    CGFloat x = xZero + index * unitWidth;
    
    //将竖线移动到该位置
    CGFloat imageViewHeight = yZero - y + 5 > 10 ? yZero - y + 5 : 10;//高度最低为选中时大圆点的高度10
    self.touchImageView.frame = CGRectMake(x - 5, y - 5, _touchImageView.frame.size.width, imageViewHeight);
    [self addSubview:_touchImageView];
    
    //判断有没有需要恢复的x轴标注
    if (lastSelectedXMark) {
        CGPoint orginCenter = lastSelectedXMark.center;
        lastSelectedXMark.font = [UIFont systemFontOfSize:10];
        [lastSelectedXMark sizeToFit];
        lastSelectedXMark.center = orginCenter;
        if (hideXMarks) {
            [lastSelectedXMark removeFromSuperview];
        }
    }
    //突出该点X轴标注
    UILabel *selectedXMark = _xMarkViews[index];
    [self addSubview:selectedXMark];
    
    CGPoint orginCenter = selectedXMark.center;
    selectedXMark.font = [UIFont systemFontOfSize:12];
    [selectedXMark sizeToFit];
    selectedXMark.center = orginCenter;
    
    lastSelectedXMark = selectedXMark;
    
    //NoticeView存在时，刷新noticeView
    if (_noticeView == nil) {
        return;
    }
    NSString *pointValueStr = [NSString stringWithFormat:@"%.3lf",pointValue];
    [_noticeView refreshInfoWithData:pointValueStr];
    
    //移动NoticeView位置
    CGPoint selectedPoint = CGPointMake(x, y);
    [self setNoticeViewLocation:selectedPoint];
    
    [self addSubview:_noticeView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [_touchImageView removeFromSuperview];
}

- (void)setNoticeViewLocation:(CGPoint)point {
    static CGFloat noticeMagin = 10;
    
    CGFloat noticeWidth = _noticeView.frame.size.width;
    CGFloat noticeHeight = _noticeView.frame.size.height;
    _noticeView.center = CGPointMake(point.x + noticeMagin + noticeWidth / 2, point.y);
    
    if (_noticeView.frame.origin.x + _noticeView.frame.size.width > fullWidth) {
        //如果右侧超出折线图,noticeView放在选中点的左边
        _noticeView.center = CGPointMake(point.x - noticeMagin - noticeWidth / 2, point.y);
    }
}

@end
