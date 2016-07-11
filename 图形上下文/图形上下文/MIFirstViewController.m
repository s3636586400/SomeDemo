//
//  MIFirstViewController.m
//  图形上下文
//
//  Created by 解炳灿 on 16/5/5.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIFirstViewController.h"

@interface MIFirstViewController ()

@end

@implementation MIFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *editImage = [self combineImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:editImage];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

- (UIImage *)customImage {
    CGSize size = CGSizeMake(256, 256);
    UIGraphicsBeginImageContext(size);
    
    UIImage *image = [UIImage imageNamed:@"samaritan"];
    [image drawInRect:CGRectMake(0, 0, 256, 256)];
    
    //添加水印
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 170, 240);
    CGContextAddLineToPoint(context, 240, 240);
    
    NSString *name = @"Samaritan";
    [name drawInRect:CGRectMake(170, 240 - 20, 70, 20) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:15],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 2);
    
    CGContextStrokePath(context);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    保存图片
//    NSData *data = UIImagePNGRepresentation(newImage);
//    [data writeToFile:@"somewhere" atomically:YES];
    
    return newImage;
    
}

- (UIImage *)combineImage {
    CGSize size = CGSizeMake(374, 180);
    UIGraphicsBeginImageContext(size);
    
    UIImage *image = [UIImage imageNamed:@"基金超市"];
    [image drawInRect:CGRectMake(0, 0, 374, 180)];
    
    UIImage *icon = [UIImage imageNamed:@"FundSuperMarket_Icon"];
    [icon drawInRect:CGRectMake(48 * 2, 34.5 * 2, 20 * 2, 21 * 2)];
    
    NSString *name = @"基金超市";
    [name drawInRect:CGRectMake(142, 34.5 * 2, 68 * 2, 21 * 2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:34],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //保存图片
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/Mask/Desktop/fundSupermarket.png" atomically:YES];
    
    return  newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
