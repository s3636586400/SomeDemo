//
//  ViewController.m
//  摄像头
//
//  Created by 解炳灿 on 16/5/10.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

//设置UIImagePicker属性时用到
#import <MobileCoreServices/MobileCoreServices.h>

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (assign, nonatomic) BOOL isVideo;//是否摄像

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) AVPlayer *player;//播放录制视频

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isVideo = YES;
}

/**
 *  打开相机
 */
- (IBAction)openCamera:(UIButton *)sender {
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //如果是照片
        UIImage *image = nil;
        if (self.imagePicker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        self.imageView.image = image;
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        //如果是视频
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlStr = [url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败：%@",[error localizedDescription]);
    }else {
        NSLog(@"视频保存成功");
        NSURL *url = [NSURL fileURLWithPath:videoPath];
        self.player = [AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = self.imageView.bounds;
        [self.imageView.layer addSublayer:playerLayer];
        [self.player play];
    }
}

#pragma Getter
- (UIImagePickerController *)imagePicker {
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        //来源设置为摄像头
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置为后置摄像头
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //允许编辑
        _imagePicker.allowsEditing = YES;
        //设置代理
        _imagePicker.delegate = self;
        
        if (self.isVideo) {
            //媒体类型-视频
            _imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
            //视频品质-1280*720
            _imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
            //设置摄像头模式-视频
            _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        }else {
            //设置摄像头模式-照相
            _imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
        
    }
    
    return _imagePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
