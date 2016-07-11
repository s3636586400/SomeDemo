//
//  ViewController.h
//  62.自定义转场动画
//
//  Created by s3636586400 on 16/6/28.
//  Copyright © 2016年 MaskIsland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ModalViewControllerDelegate <NSObject>

- (void)modalViewControllerDidClickedDismissButton:(ViewController *)viewController;

@end


@interface ViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end

