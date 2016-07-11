//
//  MIBackgroundLocateController.m
//  MapDemo
//
//  Created by 解炳灿 on 16/4/14.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MIBackgroundLocateController.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface MIBackgroundLocateController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (strong, nonatomic) UILabel *mainLabel;

@end

@implementation MIBackgroundLocateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //MainLabel
    self.mainLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    _mainLabel.textAlignment = NSTextAlignmentCenter;
    _mainLabel.numberOfLines = 0;
    [self.view addSubview:_mainLabel];
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

- (AMapLocationManager *)locationManager {
    
    if (_locationManager==nil) {
        
        _locationManager = [[AMapLocationManager alloc] init];
        
        _locationManager.delegate = self;
        
        //设置定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        
        //设置定位超时
        _locationManager.locationTimeout = 3;
        
        //设置逆地理超时
        _locationManager.reGeocodeTimeout = 3;
        
        //定位是否会被系统自动暂停
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //是否允许后台定位－仅iOS9需要该方法
        [_locationManager setAllowsBackgroundLocationUpdates:YES];
        
    }
    return _locationManager;
}

#pragma mark AMapLocationManagerDelegate
//定位失败
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    self.mainLabel.text = [error localizedDescription];
}
//持续定位更新位置
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    self.mainLabel.text = [NSString stringWithFormat:@"lat:%f,lon:%f",location.coordinate.latitude,location.coordinate.longitude];
}

- (void)dealloc {
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
