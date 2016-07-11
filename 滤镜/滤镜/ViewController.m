//
//  ViewController.m
//  滤镜
//
//  Created by 解炳灿 on 16/5/6.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImagePickerController *_imagePickerController;
    CIContext *_context;//Core Image上下文
    CIImage *_image;//编辑前图片
    CIImage *_outputImage;//编辑后图片
    CIFilter *_colorControlsFilter;//滤镜对象
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brighnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *constrastSlider;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
//    [self showAllFilters];
}

- (void)initLayout {
    //初始化图片选择器
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    //NaviItemBar
    self.navigationItem.title = @"Filter";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePhoto)];
    //初始化CIContext
    _context = [CIContext contextWithOptions:nil];//使用GPU渲染，无法跨应用访问（会自动降级为CPU渲染）推荐渲染后保存图片，主程序中调用
    
    //取得滤镜
    _colorControlsFilter = [CIFilter filterWithName:@"CIColorControls"];
}

#pragma mark 查看所有内置滤镜
- (void)showAllFilters {
    NSArray *filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames) {
        CIFilter *filter = [CIFilter filterWithName:filterName];
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
    }
}

#pragma mark 打开图片选择器
-(void)openPhoto {
    //打开图片选择页
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark 保存图片
-(void)savePhoto {
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"System Info" message:@"Save Success!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    //拿到选中图片
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = selectedImage;
    //初始化CIImage
    _image = [CIImage imageWithCGImage:selectedImage.CGImage];
    //设置输入图片
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];
    //恢复滑动条默认位置
    [self resetSlider];
}


#pragma mark Action
/**
 *  饱和度改变
 */
- (IBAction)SaturationChanged:(UISlider *)sender {
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:sender.value] forKey:@"inputSaturation"];
    [self setImage];
}

/**
 *  亮度改变
 */
- (IBAction)Brightness:(UISlider *)sender {
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:sender.value] forKey:@"inputBrightness"];
    [self setImage];
}

/**
 *  对比度改变
 */
- (IBAction)Contrast:(UISlider *)sender {
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:sender.value] forKey:@"inputBrightness"];
    [self setImage];
}

/**
 *  将输出图片设置到ImageView
 */
- (void)setImage {
    CIImage *outputImage = [_colorControlsFilter outputImage];
    CGImageRef temp = [_context createCGImage:outputImage fromRect:[outputImage extent]];
//    _imageView.image = [UIImage imageWithCGImage:temp];
//    由上面方法保存的图片方向可能会发生改变。(也有说大小页会改变的，我没遇见……)
//    Google了下,获取新image时，指定新图片的缩放和方向为原图片缩放、方向即可。
    _imageView.image = [UIImage imageWithCGImage:temp scale:_imageView.image.scale orientation:_imageView.image.imageOrientation];
    
    CGImageRelease(temp);
}

/**
 *  恢复滑动条默认位置
 */
- (void)resetSlider {
    self.saturationSlider.value = 1;
    self.brighnessSlider.value = 0;
    self.constrastSlider.value = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
