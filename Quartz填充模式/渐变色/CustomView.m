//
//  CustomView.m
//  渐变填充、有色填充、无色填充、叠加模式
//
//  Created by 解炳灿 on 16/4/28.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "CustomView.h"

#define TILE_SIZE 20

@implementation CustomView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    线性渐变
//    [self drawLinearGradient:context];
    
//    径向渐变
//    [self drawRadialGradient:context];
    
//     渐变裁剪
//    [self rectClip:context];
    
//    叠加模式
//    [self blendModel:context];
    
//    有色填充模式
//    [self drawBackgroundWithColoredPattern:context];

//    无色填充模式
    [self drawBackgroundWithPattern:context];
    
}



/**
 *  线性渐变
 */
#pragma mark 线性渐变
- (void)drawLinearGradient:(CGContextRef)context {
    //1.使用RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //2.颜色数组（指定RGB颜色空间后，四个数组元素代表一个颜色）
    CGFloat compoents[12] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    //该数组保存了三个颜色{UIColor(48,86,86,1),UIColor(249,127,127,1),UIColor(1,1,1,1)}
    //CMYK颜色空间下5个元素对应一个颜色：cyan,magenta,yello,black,alpha
    
    //3.颜色所在位置(0~1),数量不小于颜色数组中颜色数量(不知道该参数意义)
    CGFloat locations[3] = {0,0.3,1.0};
    
    //4.渐变个数,等于locations个数(不知道该参数意义)
    size_t count = 3;
    
    //5.创建GradientRef对象
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, count);
    
    //6.绘制线性渐变
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, self.frame.size.height), kCGGradientDrawsAfterEndLocation);
    
    //7.释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
}

/**
 *  径向渐变
 */
#pragma mark 径性渐变
- (void)drawRadialGradient:(CGContextRef)context {
    //1.使用RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //2.颜色数组（指定RGB颜色空间后，四个数组元素代表一个颜色）
    CGFloat compoents[12] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    //该数组保存了三个颜色{UIColor(48,86,86,1),UIColor(249,127,127,1),UIColor(1,1,1,1)}
    //CMYK颜色空间下5个元素对应一个颜色：cyan,magenta,yello,black,alpha
    
    //3.颜色所在位置(0~1),数量不小于颜色数组中颜色数量(不知道该参数意义)
    CGFloat locations[3] = {0,0.3,1.0};
    
    //4.渐变个数,等于locations个数(不知道该参数意义)
    size_t count = 3;
    
    //5.创建GradientRef对象
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, count);
    
    CGContextDrawRadialGradient(context, gradient, self.center, 0, self.center, 150, kCGGradientDrawsAfterEndLocation);
    
    CGColorSpaceRelease(colorSpace);
}

/**
 *  渐变裁剪
 */
#pragma mark 渐变裁剪
- (void)rectClip:(CGContextRef)context {
    //1.先裁剪
    UIRectClip(CGRectMake(20, 50, 280, 300));
    //2.渐变
    [self drawLinearGradient:context];
    
    //上方法只能裁剪矩形，如果画了一个折线图或者其他不规则的，可以直接裁剪路径
#if 0
    CGContextClip(context);
    [self drawLinearGradient:context];
#endif
}

/**
 *  叠加模式
 */
#pragma mark 叠加模式
- (void)blendModel:(CGContextRef)context {
    /**
     *  各种CGBlendMode……
     */
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillRect(context, CGRectMake(20, 20, 100, 50));
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(90, 35, 100, 50));
    
}

#pragma mark 有色填充模式
void drawColoredTile(void *info, CGContextRef context) {
    //有色填充，设置填充色
    CGContextSetRGBFillColor(context, 254.0/255.0, 52.0/255.0, 90.0/255.0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

/**
 *  有色填充模式
 */
-(void)drawBackgroundWithColoredPattern:(CGContextRef)context {
    //有色颜色填充模式，填充颜色空间传NULL
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    //设置颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    //填充模式的回调结构体
    CGPatternCallbacks callback = {0,&drawColoredTile,NULL};
    /**
     *  填充模式
     *
     *  @param info      callback参数
     *  @param bounds    瓷砖大小
     *  @param matrix    形变
     *  @param xStep     横向间距
     *  @param yStep     纵向间距
     *  @param tiling    三种模式
     *  @param isColored 是否已经制定了颜色
     *  @param callbacks 回调函数
     *
     *  @return 填充模式的图样
     */
    CGPatternRef pattern = CGPatternCreate(NULL, CGRectMake(0, 0, 2 * TILE_SIZE, 2 * TILE_SIZE), CGAffineTransformIdentity, 2 * TILE_SIZE, 2 * TILE_SIZE, kCGPatternTilingNoDistortion, true, &callback);
    
    //透明度
    CGFloat alpha = 1;
    CGContextSetFillPattern(context, pattern, &alpha);
    
    UIRectFill(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height));
    
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
    
}

#pragma mark 无色填充模式
void drawTile(void *info, CGContextRef context) {
    CGContextFillRect(context, CGRectMake(0, 0, TILE_SIZE, TILE_SIZE));
    CGContextFillRect(context, CGRectMake(TILE_SIZE, TILE_SIZE, TILE_SIZE, TILE_SIZE));
}

/**
 *  无色填充模式(Pattern是没有颜色的，就是板砖都是无色的，都铺完之后给了一个颜色)
 */
-(void)drawBackgroundWithPattern:(CGContextRef)context {
    //设备无关的颜色空间
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateDeviceRGB();
    //填充模式的颜色空间,无色填充模式的颜色空间不能是NULL，因为要按照该颜色空间去解析setFillPattern中颜色数组
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(rgbSpace);
    //设置颜色空间
    CGContextSetFillColorSpace(context, colorSpace);
    //填充模式的回调结构体
    CGPatternCallbacks callback = {0,&drawTile,NULL};
    /**
     *  填充模式
     *
     *  @param info      callback参数
     *  @param bounds    瓷砖大小
     *  @param matrix    形变
     *  @param xStep     横向间距
     *  @param yStep     纵向间距
     *  @param tiling    三种模式
     *  @param isColored 是否已经制定了颜色
     *  @param callbacks 回调函数
     *
     *  @return 填充模式的图样
     */
    CGPatternRef pattern = CGPatternCreate(NULL, CGRectMake(0, 0, 2 * TILE_SIZE, 2 * TILE_SIZE), CGAffineTransformIdentity, 2 * TILE_SIZE, 2 * TILE_SIZE, kCGPatternTilingNoDistortion, false, &callback);
    
    //无色填充在fillPattern时需要给一个颜色（有色填充只给了一个透明度）
    CGFloat components[] = {254.0/255.0,52.0/255.0,90.0/255.0,1.0};
    CGContextSetFillPattern(context, pattern, components);
    
    UIRectFill(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height));
    
    CGColorSpaceRelease(rgbSpace);
    CGColorSpaceRelease(colorSpace);
    CGPatternRelease(pattern);
    
}

@end
