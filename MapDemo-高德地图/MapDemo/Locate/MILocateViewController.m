//
//  MILocateViewController.m
//  MapDemo
//
//  Created by 解炳灿 on 16/4/13.
//  Copyright © 2016年 解炳灿. All rights reserved.
//

#import "MILocateViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>


@interface MILocateViewController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (strong, nonatomic) UILabel *mainLabel;

@end

@implementation MILocateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //MainLabel
    self.mainLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    _mainLabel.textAlignment = NSTextAlignmentCenter;
    _mainLabel.numberOfLines = 0;
    [self.view addSubview:_mainLabel];
    //单次定位
    __weak MILocateViewController *weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
                
            {
                return;
            }
        }
        
        if (regeocode)
        {
            weakSelf.mainLabel.text = [NSString stringWithFormat:@"%@\n%@-%@-%.2fm",regeocode.formattedAddress,regeocode.adcode,regeocode.citycode,location.horizontalAccuracy];
        }else {
            weakSelf.mainLabel.text = [NSString stringWithFormat:@"lat:%f;lon:%f",location.coordinate.latitude,location.coordinate.longitude];
        }
    }];
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
        
        //是否允许后台定位
        [_locationManager setAllowsBackgroundLocationUpdates:YES];


    }
    return _locationManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
