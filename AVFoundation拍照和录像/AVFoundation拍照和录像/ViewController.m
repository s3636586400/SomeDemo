//
//  ViewController.m
//  AVFoundation拍照和录像
//
//  Created by 解炳灿 on 16/5/11.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ImageViewerController.h"
#import "WebViewerController.h"

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface ViewController ()

//UI
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *flashAutoButton;
@property (weak, nonatomic) IBOutlet UIButton *flashOffButton;
@property (weak, nonatomic) IBOutlet UIButton *flashOnButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageShower;

@property (weak, nonatomic) IBOutlet UIButton *showViewerButton;

//容器View
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

//聚焦光标
@property (weak, nonatomic) IBOutlet UIImageView *focusCursor;


//会话对象
@property (strong, nonatomic) AVCaptureSession *captrueSession;

//输入对象
@property (strong, nonatomic) AVCaptureDeviceInput *captureDeviceInput;

//输出对象
@property (strong, nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;

//预览Layer
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureViewPreviewLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //1.初始化会话
    _captrueSession = [[AVCaptureSession alloc] init];
    if ([_captrueSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        _captrueSession.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    //2.初始化输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    if (!captureDevice) {
        NSLog(@"取得后置摄像头失败");
        return;
    }
    //3.初始化设备输入对象
    NSError *error = nil;
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"获取设备输入对象失败：%@",[error localizedDescription]);
        return;
    }
    //4.初始化设备输出对象
    self.captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出格式JPEG
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.captureStillImageOutput setOutputSettings:outputSettings];
    //5.将设备输入、输出添加到会话中
    if ([self.captrueSession canAddInput:self.captureDeviceInput]) {
        [self.captrueSession addInput:self.captureDeviceInput];
    }
    if ([self.captrueSession canAddOutput:self.captureStillImageOutput]) {
        [self.captrueSession addOutput:self.captureStillImageOutput];
    }
    //6.创建视频预览层，以展示摄像头状态
    self.captureViewPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captrueSession];
    CALayer *layer = self.viewContainer.layer;
    layer.masksToBounds = YES;
    
    self.captureViewPreviewLayer.frame = layer.bounds;
    self.captureViewPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    
    [layer insertSublayer:self.captureViewPreviewLayer below:self.focusCursor.layer];
    
    //添加通知
    [self addNotificationToCaptureDevice:captureDevice];
    //添加点击手势，点击聚焦
    [self addTapGes];
    //初始化闪光灯按钮状态
    [self setFlashModeButtonStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
/**
 *  视图出现时开始会话
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.captrueSession startRunning];
}
/**
 *  视图消失时停止会话
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.captrueSession stopRunning];
}

#pragma mark Private Method
/**
 *  获取指定位置摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

#pragma mark 改变设备属性
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange {
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    NSError *error;
    //改变设备属性，先加锁。修改之后再解锁。
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else {
        NSLog(@"设置设备属性失败.%@",[error localizedDescription]);
    }
}

#pragma mark Notification
/**
 *  输入设备添加通知
 *
 *  @param captureDevice 输入设备
 */
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice {
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //添加捕获区域发生改变时的通知
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

/**
 *  接收通知
 */
- (void)areaChange:(NSNotification *)noti {
    NSLog(@"捕获区域发生改变");
    
}

- (void)removeNotification {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

#pragma mark 点按聚焦
- (void)addTapGes {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self.viewContainer addGestureRecognizer:tap];
}
/**
 *  点击聚焦
 *
 *  @param tapGes UITapGestureRecognizer
 */
- (void)tapScreen:(UITapGestureRecognizer *)tapGes {
    CGPoint point = [tapGes locationInView:self.viewContainer];
    //UI坐标转换为摄像头坐标
    CGPoint cameraPoint = [self.captureViewPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 *  移动聚焦边框图片到点击位置
 *
 *  @param point point CGPoint点击坐标
 */
- (void)setFocusCursorWithPoint:(CGPoint)point {
    self.focusCursor.center = point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursor.alpha = 0;
    }];
}
/**
 *  设置聚焦
 *
 *  @param focusMode    聚焦模式
 *  @param exposureMode 曝光模式
 *  @param point        聚焦点坐标
 */
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point {
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        //是否支持设置聚焦模式
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
        //是否支持设置聚焦点
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        //是否支持曝光模式
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}

#pragma mark 自动闪光灯开启
- (IBAction)flashAutoClick:(UIButton *)sender {
    [self setFlashMode:AVCaptureFlashModeAuto];
    [self setFlashModeButtonStatus];
}

#pragma mark 关闭闪光灯
- (IBAction)flashOffClick:(UIButton *)sender {
    [self setFlashMode:AVCaptureFlashModeOff];
    [self setFlashModeButtonStatus];
}

#pragma mark 打开闪光灯
- (IBAction)flashOnClick:(UIButton *)sender {
    [self setFlashMode:AVCaptureFlashModeOn];
    [self setFlashModeButtonStatus];
}

#pragma mark 设置闪关灯模式
- (void)setFlashMode:(AVCaptureFlashMode)flashMode {
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:flashMode]) {
            [captureDevice setFlashMode:flashMode];
        }
    }];
}

#pragma mark 设置闪光灯按钮状态
- (void)setFlashModeButtonStatus {
    AVCaptureDevice *captureDevice = self.captureDeviceInput.device;
    AVCaptureFlashMode flashMode = captureDevice.flashMode;
    NSArray *flashButtons = @[self.flashAutoButton,self.flashOnButton,self.flashOffButton];
    
    if ([captureDevice isFlashAvailable]) {
        for (UIButton *btn in flashButtons) {
            btn.hidden = NO;
            btn.enabled = YES;
        }
        switch (flashMode) {
            case AVCaptureFlashModeOff:
                self.flashOffButton.enabled = NO;
                break;
            case AVCaptureFlashModeOn:
                self.flashOnButton.enabled = NO;
                break;
            case AVCaptureFlashModeAuto:
                self.flashAutoButton.enabled = NO;
                break;
                
            default:
                break;
        }
    }else {
        for (UIButton *btn in flashButtons) {
            btn.hidden = YES;
        }
    }
}
#pragma mark 切换摄像头
- (IBAction)switchCamera:(UIButton *)sender {
    AVCaptureDevice *currentDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [currentDevice position];
    //移除当前摄像头通知
    [self removeNotificationFromCaptureDevice:currentDevice];
    
}

/**
 *  移除设备通知
 *
 *  @param captureDevice 需要通知移除的设备
 */
- (void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

#pragma mark 拍照
- (IBAction)start:(UIButton *)sender {
    //由输出对象获取一个连接对象
    AVCaptureConnection *connection = [self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //通过输出对象输出数据到连接中
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            //CMSampleBufferRef转成NSData
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            //NSData转成UIImage
            UIImage *image = [UIImage imageWithData:imageData];
            //保存到相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            //显示到UI
            self.imageShower.image = image;
            //展示按钮可用
            self.showViewerButton.enabled = YES;
        }
    }];
}

#pragma mark 展示图片
- (IBAction)showImageViewer:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
#if 1
    ImageViewerController *viewer = [storyboard instantiateViewControllerWithIdentifier:@"imageViewerController"];
    viewer.image = self.imageShower.image;
    [self presentViewController:viewer animated:YES completion:nil];
#else
    WebViewerController *webViewer = [storyboard instantiateViewControllerWithIdentifier:@"webViewerController"];
    webViewer.data = UIImageJPEGRepresentation(self.imageShower.image, 1.0);
    [self presentViewController:webViewer animated:YES completion:nil];
#endif
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc {
    [self removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
