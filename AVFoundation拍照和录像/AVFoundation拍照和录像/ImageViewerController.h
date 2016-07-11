//
//  ImageViewerController.h
//  AVFoundation拍照和录像
//
//  Created by 解炳灿 on 16/5/11.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@end
