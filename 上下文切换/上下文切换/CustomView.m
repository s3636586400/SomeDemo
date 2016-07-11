//
//  CustomView.m
//  上下文切换
//
//  Created by 解炳灿 on 16/5/5.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawImage:context];
//    [self drawImageWithCoreGraphics:context];
}

- (void)drawImage:(CGContextRef)context {
    
    //保存上下文
    CGContextSaveGState(context);
    //平移
    CGContextTranslateCTM(context, 100, 0);
    //缩放0.6
    CGContextScaleCTM(context, 0.6, 0.6);
    //旋转45°
    CGContextRotateCTM(context, M_PI_4);
    //绘制图片
    UIImage *image = [UIImage imageNamed:@"star"];
    
    [image drawInRect:CGRectMake(0, 50, image.size.width, image.size.height)];
    //恢复上下文
    CGContextRestoreGState(context);
    
    
    //由于绘图时操作同一个上下文对象，绘制不同图案时上下文对象设置不同，为避免影响其他部分，需切换上下文
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //如果不切换（保存-恢复）上下文，该矩形也会平移缩放旋转
    CGContextFillRect(context, CGRectMake(100, 300, 100, 60));
}

- (void)drawImageWithCoreGraphics:(CGContextRef)context {
    /**
     *  Quartz2D的坐标系原点在左下角，UIKit原点在左上角。
     *  UIKit中的方法已经替我们统一了。
     *  直接用Core Graphics绘图，其实是倒过来的
     *  为什么画点线圆都是正确的，就画图片是反的。
     */
    UIImage *image = [UIImage imageNamed:@"star"];
    CGContextDrawImage(context, CGRectMake(0, 50, image.size.width, image.size.height), image.CGImage);
}

@end
